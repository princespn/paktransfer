<?php

namespace App\Http\Controllers\Agent;

use App\Http\Controllers\Controller;
use App\Http\Traits\WithdrawProcess;
use App\Models\UserWithdrawMethod;
use App\Models\Withdrawal;

class AgentWithdrawController extends Controller
{
    use WithdrawProcess;

    public function __construct()
    {
        $this->activeTemplate = activeTemplate();
    }
    public function withdrawMoney()
    {
        $userMethods = UserWithdrawMethod::myWithdrawMethod()->get();
        $pageTitle = 'Withdraw Money';
        return view($this->activeTemplate.'agent.withdraw.withdraw_money', compact('pageTitle','userMethods'));
    }
    public function withdrawMethods()
    {
        $userMethods = UserWithdrawMethod::myWithdrawMethod()->paginate(getPaginate());
        $pageTitle = 'Withdraw Methods';
        return view($this->activeTemplate.'agent.withdraw.methods', compact('pageTitle','userMethods'));
    }


    public function withdrawPreview()
    {
        $withdraw = Withdrawal::with('method','agent')->where('trx', session()->get('wtrx'))->where('status', 0)->orderBy('id','desc')->firstOrFail();
        $pageTitle = 'Withdraw Preview';
        return view($this->activeTemplate . 'agent.withdraw.preview', compact('pageTitle','withdraw'));
    }


    public function withdrawLog()
    {
        $pageTitle = "Withdraw Log";
        $user = userGuard()['user'];
        $userType = userGuard()['type'];
        $withdraws = Withdrawal::where('user_id',$user->id)->where('user_type',$userType)->where('status', '!=', 0)->with('method')->whereHas('method')->orderBy('id','desc')->paginate(getPaginate());
        $emptyMessage = "No Data Found!";
        return view($this->activeTemplate.'agent.withdraw.log', compact('pageTitle','withdraws','emptyMessage'));
    }
}
