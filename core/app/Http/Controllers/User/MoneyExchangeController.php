<?php

namespace App\Http\Controllers\User;
use App\Http\Controllers\Controller;
use App\Models\Wallet;
use App\Models\Currency;
use App\Models\Transaction;
use App\Models\TransactionCharge;
use Illuminate\Http\Request;

class MoneyExchangeController extends Controller
{
    public function __construct() {
        $this->activeTemplate = activeTemplate();
    }

    public function exchangeForm()
    {
        $exchangeCharge = TransactionCharge::where('slug','exchange_charge')->first();
        $pageTitle = "Exchange Money";
        return view($this->activeTemplate.'user.exchange.exchange_form',compact('pageTitle','exchangeCharge'));
    }

    public function exchangeConfirm(Request $request)
    {
        $request->validate([
            'amount' => 'required|gt:0',
            'from_wallet_id' => 'required|integer',
            'to_wallet_id' => 'required|integer',
        ],
        [
            'from_wallet_id.required' => 'Your wallet currency is required from which you want to exchange.',
            'to_wallet_id.required' => 'Your wallet currency is required to which you want to exchange.'
        ]);

        $exchangeCharge = TransactionCharge::where('slug','exchange_charge')->first();
        $fromWallet = Wallet::checkWallet(['user'=>auth()->user(),'type'=>'USER'])->find($request->from_wallet_id);
        if(!$fromWallet){
            $notify[]=['error','Your wallet currency is not found from which you want to exchange.'];
            return back()->withNotify($notify);
        }
        $toWallet = Wallet::find($request->to_wallet_id);
        if(!$toWallet){
            $notify[]=['error','Your wallet currency is not found to which you want to exchange.'];
            return back()->withNotify($notify);
        }

        if($fromWallet->id == $toWallet->id){
            $notify[]=['error',"Can\'t exchange money to same wallet"];
            return back()->withNotify($notify);
        }


        //converting charges to FROM wallet currency
        $fromWalletAmount = $request->amount;
        $fixedCharge = $exchangeCharge->fixed_charge/$fromWallet->currency->rate;
        $totalFromWalletCharge = chargeCalculator($fromWalletAmount,$exchangeCharge->percent_charge,$fixedCharge);

        $cap = $exchangeCharge->cap/$fromWallet->currency->rate;
        if($exchangeCharge->cap != -1 && $totalFromWalletCharge > $cap){
            $totalFromWalletCharge = $cap;
        }

        if($totalFromWalletCharge > $fromWallet->balance){
            $notify[]=['error',"Your don\'t have sufficient balance from which you want to exchange"];
            return back()->withNotify($notify);
        }
        //$fromWalletAmount += $totalFromWalletCharge; //total amount of FROM currency including charge

        $baseCurrAmount =  $fromWallet->currency->rate * ($request->amount-$totalFromWalletCharge); // converting amount to site default currency
//var_dump($totalFromWalletCharge);
//var_dump($baseCurrAmount);
//var_dump($fromWalletAmount);
//exit;
        if($toWallet->currency->currency_type == 1){
            $finalAmount = getAmount($baseCurrAmount/$toWallet->currency->rate,2); // converting amount to expected currency
        } else {
            $finalAmount = getAmount($baseCurrAmount/$toWallet->currency->rate,8);

        }

        $fromWallet->balance -=  $fromWalletAmount;
        $fromWallet->save();

        $fromWalletTrx = new Transaction();
        $fromWalletTrx->user_id = auth()->id();
        $fromWalletTrx->user_type = 'USER';
        $fromWalletTrx->wallet_id = $fromWallet->id;
        $fromWalletTrx->currency_id = $fromWallet->currency_id;
        $fromWalletTrx->before_charge =  $request->amount;
        $fromWalletTrx->amount =  $fromWalletAmount;
        $fromWalletTrx->post_balance = $fromWallet->balance;
        $fromWalletTrx->charge =  $totalFromWalletCharge;
        $fromWalletTrx->charge_type =  '-';
        $fromWalletTrx->trx_type = '-';
        $fromWalletTrx->operation_type = 'exchange_money';
        $fromWalletTrx->details = 'Exchange Money (From)';
        $fromWalletTrx->trx = getTrx();
        $fromWalletTrx->save();

        $toWallet->balance += $finalAmount;
        $toWallet->save();

        $toWalletTrx = new Transaction();
        $toWalletTrx->user_id = auth()->id();
        $toWalletTrx->user_type = 'USER';
        $toWalletTrx->wallet_id = $toWallet->id;
        $toWalletTrx->currency_id = $toWallet->currency_id;
        $toWalletTrx->before_charge =  $finalAmount;
        $toWalletTrx->amount =  $finalAmount;
        $toWalletTrx->post_balance = $toWallet->balance;
        $toWalletTrx->charge =  0;
        $toWalletTrx->charge_type =  '+';
        $toWalletTrx->trx_type = '+';
        $toWalletTrx->operation_type = 'exchange_money';
        $toWalletTrx->details = 'Exchange Money (To)';
        $toWalletTrx->trx = $fromWalletTrx->trx;
        $toWalletTrx->save();

        notify(auth()->user(),'EXCHANGE_MONEY',[
            'from_wallet_amount' => $request->amount,
            'from_wallet_curr' => $fromWallet->currency->currency_code,
            'to_wallet_amount' => showAmount($finalAmount,$fromWallet->currency),
            'to_wallet_curr' => $toWallet->currency->currency_code,
            'from_balance' => showAmount($fromWallet->balance,$fromWallet->currency),
            'to_balance' => showAmount($toWallet->balance,$fromWallet->currency),
            'trx' => $fromWalletTrx->trx,
            'time' => showDateTime($fromWalletTrx->created_at,'d/M/Y @h:i a')
        ]);

        $notify[]=['success','Money exchanged successfully'];
        //return back()->withNotify($notify);
         return back()->with('front_sess_mess','Exchange successful')->withNotify($notify);

    }
}