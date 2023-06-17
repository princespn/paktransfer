<?php

namespace App\Http\Controllers\Gateway;

use App\Models\TransactionCharge;
use App\Models\User;
use App\Models\Agent;
use App\Models\Wallet;
use App\Models\Deposit;
use App\Models\Currency;
use App\Models\Transaction;
use Illuminate\Http\Request;
use App\Models\GatewayCurrency;
use App\Rules\FileTypeValidate;
use App\Models\AdminNotification;
use App\Http\Controllers\Controller;

class PaymentController extends Controller
{
    public function __construct()
    {
        return $this->activeTemplate = activeTemplate();
    }

    public function deposit()
    {
        $pageTitle = 'Payment Methods';
        return view($this->activeTemplate . gatewayView('deposit'), compact('pageTitle'));
    }

    public function depositInsert(Request $request)
    {
        $request->validate([
            'amount' => 'required|numeric|gt:0',
            'method_code' => 'required',
            'currency' => 'required',
        ]);

        $user = userGuard()['user'];
        $exchangeCharge = TransactionCharge::where('slug','exchange_charge')->first();
        $currency = Currency::where('status',1)->find($request->currency_id);
        if(!$currency) {
            $notify[] = ['error', 'Invalid currency'];
            return back()->withNotify($notify);
        }

        $gate = GatewayCurrency::whereHas('method', function ($gate) {
            $gate->where('status', 1);
        })->where('method_code', $request->method_code)->where('currency', $request->currency)->first();

        if(!$gate) {
            $notify[] = ['error', 'Invalid gateway'];
            return back()->withNotify($notify);
        }

        if ($gate->min_amount >  $request->amount || $gate->max_amount <  $request->amount) {
            $notify[] = ['error', 'Please follow the limits'];
            return back()->withNotify($notify);
        }

        $charge = $gate->fixed_charge + ($request->amount * $gate->percent_charge / 100);
        $wallet = Wallet::where('id',$request->wallet_id)->first();
        if($gate->currency != $wallet->currency_code){
            if($exchangeCharge->percent_charge > 0){
                $charge += $request->amount*$exchangeCharge->percent_charge/100;
            }
            if($exchangeCharge->fixed_charge > 0){
                $charge += $exchangeCharge->fixed_charge/$currency->rate;
            }
        }

        $final_amo = $request->amount + $charge;

        $data = new Deposit();
        $data->user_id = $user->id;
        $data->user_type = userGuard()['type'];
        $data->wallet_id = $request->wallet_id;
        $data->currency_id = $request->currency_id;
        $data->method_code = $gate->method_code;
        $data->method_currency = strtoupper($gate->currency);
        $data->amount = $request->amount-$charge;
        $data->charge = $charge;
        $data->rate = $request->rate;
        $data->final_amo = $final_amo-$charge;
        $data->btc_amo = 0;
        $data->btc_wallet = "";
        $data->trx = getTrx();
        $data->try = 0;
        $data->status = 0;
        $data->save();
        session()->put('Track', $data->trx);
        return redirect()->route(strtolower(userGuard()['type']).'.deposit.confirm');
    }


    public function depositConfirm()
    {
        $track = session()->get('Track');
        $deposit = Deposit::where('trx', $track)->where('status',0)->orderBy('id', 'DESC')->with('gateway')->firstOrFail();

        if ($deposit->method_code >= 1000) {
            return redirect()->route(strtolower(userGuard()['type']).'.deposit.manual.confirm');
        }


        $dirName = $deposit->gateway->alias;
        $new = __NAMESPACE__ . '\\' . $dirName . '\\ProcessController';

        $data = $new::process($deposit);
        $data = json_decode($data);


        if (isset($data->error)) {
            $notify[] = ['error', $data->message];
            return redirect()->route(gatewayRedirectUrl())->withNotify($notify);
        }
        if(isset($data->redirect)) {
            return redirect($data->redirect_url);
        }

        // for Stripe V3
        if(@$data->session){
            $deposit->btc_wallet = $data->session->id;
            $deposit->save();
        }

        $pageTitle = 'Payment Confirm';
        return view($this->activeTemplate . $data->view, compact('data', 'pageTitle', 'deposit'));
    }


    public static function userDataUpdate($trx)
    {
        $data = Deposit::where('trx', $trx)->first();
        if($data->status == 0) {
            $data->status = 1;
            $data->save();

            if($data->user_type == 'USER'){
                $user = User::find($data->user_id);
            } else if($data->user_type == 'AGENT'){
                $user = Agent::find($data->user_id);
            }
            $userWallet = Wallet::find($data->wallet_id);
            $userWallet->balance += $data->amount*$data->rate;
            $userWallet->save();

            $transaction = new Transaction();
            $transaction->user_id = $user->id;
            $transaction->user_type = $data->user_type;
            $transaction->wallet_id = $userWallet->id;
            $transaction->currency_id = $data->wallet->currency_id;
            $transaction->before_charge = $data->amount;
            $transaction->amount = $data->amount*$data->rate;
            $transaction->post_balance = $userWallet->balance;
            $transaction->charge = 0;
            $transaction->operation_type =  'add_money';
            $transaction->trx_type = '+';
            $transaction->details = 'Add money successful';
            $transaction->trx = $data->trx;
            $transaction->save();


            $adminNotification = new AdminNotification();
            $adminNotification->user_type = $data->user_type;
            $adminNotification->user_id = $user->id;
            $adminNotification->title = 'Add money successful via '.$data->gatewayCurrency()->name;
            $adminNotification->click_url = urlPath('admin.deposit.successful');
            $adminNotification->save();

            notify($user, 'DEPOSIT_COMPLETE', [
                'method_name' => $data->gatewayCurrency()->name,
                'method_currency' => $data->method_currency,
                'method_amount' => showAmount($data->final_amo,getCurrency($data->method_currency)),
                'amount' => showAmount($data->amount*$data->rate,$data->curr),
                'charge' => showAmount($data->charge,$data->curr),
                'currency' => $data->curr->currency_code,
                'rate' => showAmount(1,$data->curr),
                'trx' => $data->trx,
                'post_balance' => showAmount($userWallet->balance,$data->curr)
            ]);


        }
    }

    public function manualDepositConfirm()
    {
        $track = session()->get('Track');
        $data = Deposit::with('gateway')->where('status', 0)->where('trx', $track)->first();
        if (!$data) {
            return redirect()->route(gatewayRedirectUrl());
        }
        if ($data->method_code > 999) {
            $pageTitle = 'Confirm Payment';
            $method = $data->gatewayCurrency();
            return view($this->activeTemplate . gatewayView('manual_confirm',true), compact('data', 'pageTitle', 'method'));
        }
        abort(404);
    }

    public function manualDepositUpdate(Request $request)
    {
        $track = session()->get('Track');
        $data = Deposit::with('gateway')->where('status', 0)->where('trx', $track)->first();
        if($data->user_type == 'USER'){
            $user = User::find($data->user_id);
        } else if($data->user_type == 'AGENT'){
            $user = Agent::find($data->user_id);
        }
        if (!$data) {
            return redirect()->route(gatewayRedirectUrl());
        }

        $params = json_decode($data->gatewayCurrency()->gateway_parameter);

        $rules = [];
        $inputField = [];
        $verifyImages = [];

        if ($params != null) {
            foreach ($params as $key => $custom) {
                $rules[$key] = [$custom->validation];
                if ($custom->type == 'file') {
                    array_push($rules[$key], 'image');
                    array_push($rules[$key], new FileTypeValidate(['jpg','jpeg','png']));
                    array_push($rules[$key], 'max:2048');

                    array_push($verifyImages, $key);
                }
                if ($custom->type == 'text') {
                    array_push($rules[$key], 'max:191');
                }
                if ($custom->type == 'textarea') {
                    array_push($rules[$key], 'max:300');
                }
                $inputField[] = $key;
            }
        }
        $this->validate($request, $rules);

        $directory = date("Y")."/".date("m")."/".date("d");
        $path = imagePath()['verify']['deposit']['path'].'/'.$directory;
        $collection = collect($request);
        $reqField = [];
        if ($params != null) {
            foreach ($collection as $k => $v) {
                foreach ($params as $inKey => $inVal) {
                    if ($k != $inKey) {
                        continue;
                    } else {
                        if ($inVal->type == 'file') {
                            if ($request->hasFile($inKey)) {
                                try {
                                    $reqField[$inKey] = [
                                        'field_name' => $directory.'/'.uploadImage($request[$inKey], $path),
                                        'type' => $inVal->type,
                                    ];
                                } catch (\Exception $exp) {
                                    $notify[] = ['error', 'Could not upload your ' . $inKey];
                                    return back()->withNotify($notify)->withInput();
                                }
                            }
                        } else {
                            $reqField[$inKey] = $v;
                            $reqField[$inKey] = [
                                'field_name' => $v,
                                'type' => $inVal->type,
                            ];
                        }
                    }
                }
            }
            $data->detail = $reqField;
        } else {
            $data->detail = null;
        }

        $data->status = 2; // pending
        $data->save();


        $adminNotification = new AdminNotification();
        $adminNotification->user_type = $data->user_type;
        $adminNotification->user_id = $user->id;
        $adminNotification->title = 'Add money request from '.$user->username;
        $adminNotification->click_url = urlPath('admin.deposit.details',$data->id);
        $adminNotification->save();

        notify($user, 'DEPOSIT_REQUEST', [
            'method_name' => $data->gatewayCurrency()->name,
            'method_currency' => $data->method_currency,
            'method_amount' => showAmount($data->final_amo,getCurrency($data->method_currency)),
            'amount' => showAmount($data->amount,$data->cur),
            'charge' => showAmount($data->charge,$data->cur),
            'currency' => $data->curr->currency_code,
            'rate' => showAmount(1,$data->cur),
            'trx' => $data->trx,
        ]);

        $notify[] = ['success', 'You add money request has been taken.'];
        return redirect()->route(strtolower(userGuard()['type']).'.deposit.history')->withNotify($notify);
    }


}