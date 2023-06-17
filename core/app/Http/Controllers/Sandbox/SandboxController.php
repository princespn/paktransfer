<?php

namespace App\Http\Controllers\Sandbox;

use App\Http\Controllers\Controller;
use App\User;
use App\UserApiKey;
use App\Wallet;
use Illuminate\Http\Request;


use App\Currency;
use App\GeneralSetting;
use App\Sandbox;
use Validator;
use Auth;

class SandboxController extends Controller
{
    public function initiate(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'public_key' => 'required',
            'amount' => 'required|numeric|regex:/^\d*(\.\d{1,2})?$/',
            'currency' => 'required',
            'details' => 'required',
            'custom' => 'required|max:32',
            'ipn_url' => 'required|url',
            'success_url' => 'required|url',
            'cancel_url' => 'required|url',
            'email' => 'required|email',
            'name' => 'required|max:30'
        ]);
        $basic = GeneralSetting::first();
        if ($validator->fails()) {
            return response()->json(['error'=>'error','message'=>$validator->errors()]);
        }

        $userApiKey =  UserApiKey::where('public_key',trim($request->public_key))->first();

        if(!$userApiKey){
            return response()->json(['error'=>'error','message'=>'Invalid Public Key']);
        }

        $reqCurrency = strtoupper(trim($request->currency));

        $currency = Currency::where('code', $reqCurrency)->first();
        if (!$currency) {
            return response()->json(['error'=>'error','message'=>'Invalid Currency!']);
        }

        $merchant = User::where('id',$userApiKey->user_id)->where('status', 1)->first();

        if (!$merchant) {
            return response()->json(['error'=>'error','message'=>'Invalid Merchant!']);
        }

        $merchantWallet = Wallet::where('user_id', $merchant->id)->where('wallet_id', $currency->id)->first();
        if (!$merchantWallet) {
            return response()->json(['error'=>'error','message'=>'Invalid Merchant Wallet!']);
        }

        $apiPaymentTrx = getTrx();

        $all_data['name'] = $request->name;
        $all_data['email'] = trim(strtolower($request->email));

        $all_data['amount'] = $request->amount;
        $all_data['currency'] = strtoupper($currency->code);

        $all_data['details'] = $request->details;
        $all_data['custom'] = $request->custom;
        $all_data['ipn_url'] = str_replace("\/", "/", $request->ipn_url);
        $all_data['success_url'] = str_replace("\/", "/", $request->success_url);
        $all_data['cancel_url'] = str_replace("\/", "/", $request->cancel_url);
        $all_data['public_key'] = trim($request->public_key);

        $apiPay['trx'] = $apiPaymentTrx;

        $apiPay['all_data'] = json_encode($all_data);

        $api_charge = json_decode($basic->api_charge);

        $chargeAmo = $request->amount*($api_charge->percent_charge/100)+$api_charge->fix_charge;

        $apiPay['amount'] = $request->amount;
        $apiPay['charge'] = $chargeAmo;
        $apiPay['wallet_amount'] = $request->amount-$chargeAmo;
        $apiPay['currency_id'] = $currency->id;
        $data =  Sandbox::create($apiPay);


        session()->put('dataPayment', $apiPaymentTrx);
        return redirect()->route('express.sandbox.preview');
    }

    public function previewPayment(Request $request)
    {
         $transaction = session()->get('dataPayment');

        if (isset($transaction)) {
            $apiPayment = Sandbox::where('trx', $transaction)->latest()->first();

            if (!$apiPayment) {
                return response()->json(['error'=>'error','message'=>"Opps! Something Wrong!!"]);
            }
            if($apiPayment->status==1){
                $apiPay_all_data = json_decode($apiPayment->all_data, true);
                return redirect($apiPay_all_data['success_url']);
            }

            $data['apiPayment'] = $apiPayment;
            $allData = json_decode($apiPayment->all_data);
            $data['page_title'] = "Payment Preview";
            $data['make_trx'] = strtoupper(hash_hmac('sha256', $apiPayment->amount, $transaction));
            return view(activeTemplate().'sandbox.pay-preview', $data, compact('allData'));
        }

        return response()->json(['error'=>'error','message'=>"Opps! Something Wrong!!"]);
    }

    public function previewConfirmPayment(Request $request){
        $transaction = session()->get('dataPayment');



        if (isset($transaction)) {
            $apiPayment = Sandbox::where('trx', $transaction)->latest()->first();


            if (!$apiPayment) {
                return response()->json(['error'=>'error','message'=>"Opps! Something Wrong!!"]);
            }
            $allData = json_decode($apiPayment->all_data,true);

            if($apiPayment->status==1){
                return redirect($allData['cancel_url']);
            }


            sendIPN_TEST_CARD_Response($apiPayment->trx);

            $apiPayment->status = 1;
            $apiPayment->save();

            return redirect($allData['success_url']);

        }

        return response()->json(['error'=>'error','message'=>"Opps! Something Wrong!!"]);
    }

}
