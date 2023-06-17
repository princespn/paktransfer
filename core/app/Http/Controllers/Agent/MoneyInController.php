<?php

namespace App\Http\Controllers\Agent;

use App\Http\Controllers\Controller;
use App\Lib\UserActionProcess;
use App\Models\Transaction;
use App\Models\TransactionCharge;
use App\Models\User;
use App\Models\UserAction;
use App\Models\Wallet;
use Illuminate\Http\Request;

class MoneyInController extends Controller
{
    public function __construct() {
        $this->activeTemplate = activeTemplate();
    }

    public function checkUser(Request $request){
        $exist['data'] = User::where('username',$request->user)->orWhere('email',$request->user)->first();
        return response($exist);
    }

   
    public function moneyInForm()
    {
        $pageTitle = "Money In";
        $moneyInCharge = TransactionCharge::where('slug','money_in_charge')->first();
        $wallets = Wallet::checkWallet(['user'=>agent(),'type'=>'AGENT'])->where('balance','>',0)->with('currency')->get();
        return view($this->activeTemplate.'agent.money_in.money_in_form',compact('pageTitle','moneyInCharge','wallets'));
    }

    public function confirmMoneyIn(Request $request)
    {
        
        $request->validate([
            'wallet_id' => 'required|integer',
            'amount' => 'required|gt:0',
            'user' => 'required',
            'otp_type'=>'nullable|in:email,sms,2fa'
        ]);
 

        $moneyInCharge = TransactionCharge::where('slug','money_in_charge')->firstOrFail();
        if($moneyInCharge->daily_limit != -1 && agent()->trxLimit('money_out')['daily'] > $moneyInCharge->daily_limit){
            $notify[]=['error','Your daily money in limit exceeded'];
            return back()->withNotify($notify)->withInput();
        }
        
        if( $moneyInCharge->monthly_limit != 1 && agent()->trxLimit('money_out')['monthly'] > $moneyInCharge->monthly_limit){
            $notify[]=['error','Your monthly money in limit exceeded'];
            return back()->withNotify($notify)->withInput();
        }

        $agentWallet = Wallet::checkWallet(['user'=>agent(),'type'=>'AGENT'])->find($request->wallet_id);
        if(!$agentWallet){
            $notify[]=['error','Wallet Not found'];
            return back()->withNotify($notify)->withInput();
        }
 
        $user = User::where('username',$request->user)->orWhere('email',$request->user)->first();
        if(!$user){
            $notify[]=['error','Sorry! User Not Found'];
            return back()->withNotify($notify)->withInput();
        }

       $userWallet = Wallet::checkWallet(['user'=>$user,'type'=>'USER'])->where('currency_id', $agentWallet->currency->id)->first();
       if(!$userWallet){
            $userWallet = new Wallet();
            $userWallet->user_id = $user->id;
            $userWallet->user_type = 'USER';
            $userWallet->currency_id =  $agentWallet->currency_id;
            $userWallet->currency_code =  $agentWallet->currency->currency_code;
            $userWallet->save(); 
        
        }

       $rate = $agentWallet->currency->rate;
    
       if($request->amount < currencyConverter($moneyInCharge->min_limit,$rate) || $request->amount > currencyConverter($moneyInCharge->max_limit,$rate)){
           $notify[]=['error','Please Follow the money in limit'];
           return back()->withNotify($notify)->withInput();
       }

       
       //agent commission
       $fixedCommission = currencyConverter($moneyInCharge->agent_commission_fixed,$rate);
       $percentCommission = $request->amount * $moneyInCharge->agent_commission_percent/100;
       $totalCommission = $fixedCommission + $percentCommission;
       
        if($agentWallet->currency->currency_type == 1){
            $precesion = 2;
        } else {
            $precesion = 8;
        }
     
       if($request->amount > $agentWallet->balance){
            $notify[]=['error','Sorry! insufficient balance in this wallet'];
            return back()->withNotify($notify)->withInput(); 
       }


       $userAction = new UserActionProcess();
       $userAction->user_id = agent()->id;
       $userAction->user_type = userGuard()['type'];
       $userAction->act = 'money_in';
       $userAction->details = [
            'agentWallet_id'=>$agentWallet->id,
            'user_id'=>$user->id,
            'amount'=>$request->amount,
            'totalCommission'=>$totalCommission,
            'done_route'=>route('agent.money.in.done'),
       ];
       $userAction->type = $request->otp_type;
       $userAction->submit();
       return redirect($userAction->next_route);

  }

  public function moneyInDone(){

        $userAction = UserAction::where('user_id',agent()->id)->where('user_type','agent')->where('id',session('action_id'))->first();
        if(!$userAction){
            $notify[] = ['error','Sorry! Unable to Process'];
            return back()->withNotify($notify);
        }
        $details = $userAction->details;

        $agentWallet = Wallet::checkWallet(['user'=>agent(),'type'=>'AGENT'])->find($details->agentWallet_id);
        if(!$agentWallet){
            $notify[]=['error','Wallet Not found'];
            return back()->withNotify($notify)->withInput();
        }

        $user = User::where('id',$details->user_id)->first();
        if(!$user){
            $notify[]=['error','Sorry! User Not Found'];
            return back()->withNotify($notify)->withInput();
        }

        $userWallet = Wallet::checkWallet(['user'=>$user,'type'=>'USER'])->where('currency_id', $agentWallet->currency->id)->first();

        $agentWallet->balance -= $details->amount;
        $agentWallet->save();

        $agentTrx = new Transaction();
        $agentTrx->user_id = agent()->id;
        $agentTrx->user_type = 'AGENT';
        $agentTrx->wallet_id = $agentWallet->id;
        $agentTrx->currency_id = $agentWallet->currency_id;
        $agentTrx->before_charge = $details->amount;
        $agentTrx->amount = $details->amount;
        $agentTrx->post_balance = $agentWallet->balance;
        $agentTrx->charge =  0;
        $agentTrx->charge_type = '+';
        $agentTrx->trx_type = '-';
        $agentTrx->operation_type = 'money_in';
        $agentTrx->details = 'Money in to';
        $agentTrx->receiver_id = $user->id;
        $agentTrx->receiver_type = 'USER';
        $agentTrx->trx = getTrx();
        $agentTrx->save();
      
        $userWallet->balance += $details->amount;
        $userWallet->save();
        
        $userTrx = new Transaction();
        $userTrx->user_id = $user->id;
        $userTrx->user_type = 'USER';
        $userTrx->wallet_id = $userWallet->id;
        $userTrx->currency_id = $userWallet->currency_id;
        $userTrx->before_charge = $details->amount;
        $userTrx->amount = $details->amount;
        $userTrx->post_balance = $userWallet->balance;
        $userTrx->charge =  0;
        $userTrx->charge_type = '+';
        $userTrx->trx_type = '+';
        $userTrx->operation_type = 'money_in';
        $userTrx->details = 'Money in money from';
        $agentTrx->receiver_id =  agent()->id;
        $agentTrx->receiver_type = 'AGENT';
        $userTrx->trx = $agentTrx->trx;
        $userTrx->save();
        
        if ($details->totalCommission) {
            $agentWallet->balance +=  $details->totalCommission;
            $agentWallet->save();
            
            $agentCommissionTrx = new Transaction();
            $agentCommissionTrx->user_id = agent()->id;
            $agentCommissionTrx->user_type = 'AGENT';
            $agentCommissionTrx->wallet_id = $agentWallet->id;
            $agentCommissionTrx->currency_id = $agentWallet->currency_id;
            $agentCommissionTrx->before_charge = $details->totalCommission;
            $agentCommissionTrx->amount = $details->totalCommission;
            $agentCommissionTrx->post_balance = $agentWallet->balance;
            $agentCommissionTrx->charge =  0;
            $agentCommissionTrx->charge_type = '+';
            $agentCommissionTrx->trx_type = '+';
            $agentCommissionTrx->remark = 'commission';
            $agentCommissionTrx->operation_type = 'money_in';
            $agentCommissionTrx->details = 'Money in commission';
            $agentCommissionTrx->trx = $agentTrx->trx;
            $agentCommissionTrx->save();
        }
        
        
        // to user
        notify($user,'MONEY_IN',[
            'amount'=> showAmount($details->amount,$userWallet->currency),             
            'curr_code' => $userWallet->currency->currency_code,
            'agent' => agent()->username,
            'trx' => $agentTrx->trx,
            'time' => showDateTime($agentTrx->created_at,'d/M/Y @h:i a'),
            'balance' => showAmount($userWallet->balance,$userWallet->currency),
        ]);
        
        //to agent
        notify(agent(),'MONEY_IN_AGENT',[
            'amount'=> showAmount($details->amount,$agentWallet->currency),
            'charge' => 0,
            'curr_code' => $agentWallet->currency->currency_code,
            'user' => $user->fullname,
            'trx' => $agentTrx->trx,
            'time' => showDateTime($agentTrx->created_at,'d/M/Y @h:i a'),
            'balance' => showAmount($agentWallet->balance - $details->totalCommission,$agentWallet->currency),
        ]);

        //agent commission
        notify(agent(),'MONEY_IN_COMMISSION_AGENT',[
            'amount'=> showAmount($details->amount,$agentWallet->currency),
            'curr_code' => $agentWallet->currency->currency_code,
            'commission' => showAmount($details->totalCommission,$agentWallet->currency),
            'trx' => $agentTrx->trx,
            'time' => showDateTime($agentTrx->created_at,'d/M/Y @h:i a'),
            'balance' => showAmount($agentWallet->balance,$agentWallet->currency),
        ]);

    
        $notify[]=['success','Money in successful'];
        return redirect()->route('agent.money.in')->withNotify($notify);
  }
}