<?php

namespace App\Http\Controllers\User;
use App\Http\Controllers\Controller;
use App\Http\Traits\WithdrawProcess;
use App\Models\UserWithdrawMethod;
use App\Models\Withdrawal;
use App\Models\WithdrawMethod;
use Illuminate\Http\Request;

class UserWithdrawController extends Controller
{
    use WithdrawProcess;

    public function __construct()
    {
        $this->activeTemplate = activeTemplate();
    }
    public function withdrawMoney()
    {
        $userMethods = UserWithdrawMethod::myWithdrawMethod()->get();
        $withdrawMethods = WithdrawMethod::where('status',1)->get();
        $pageTitle = 'Withdraw Money';
        return view($this->activeTemplate.'user.withdraw.withdraw_money', compact('pageTitle','userMethods','withdrawMethods'));
    }
    public function withdrawMethods()
    {
        $userMethods = UserWithdrawMethod::myWithdrawMethod()->whereHas('withdrawMethod')->paginate(getPaginate());
        $pageTitle = 'Withdraw Methods';
        return view($this->activeTemplate.'user.withdraw.methods', compact('pageTitle','userMethods'));
    }

    public function withdrawPreview()
    {
        $withdraw = Withdrawal::with('method','user')->where('trx', session()->get('wtrx'))->where('status', 0)->orderBy('id','desc')->firstOrFail();
        $pageTitle = 'Withdraw Preview';
        return view($this->activeTemplate . 'user.withdraw.preview', compact('pageTitle','withdraw'));
    }

    public function withdrawLog()
    {
        $pageTitle = "Withdraw Log";
        $user = userGuard()['user'];
        $userType = userGuard()['type'];
        $withdraws = Withdrawal::where('user_id',$user->id)->where('user_type',$userType)->where('status', '!=', 0)->with('method')->whereHas('method')->orderBy('id','desc')->paginate(getPaginate());
        $emptyMessage = "No Data Found!";
        return view($this->activeTemplate.'user.withdraw.log', compact('pageTitle','withdraws','emptyMessage'));
    }

    public function withdrawAddMethod(Request $request)
    {
        $method = WithdrawMethod::where('id', $request->id)->first();
        return view($this->activeTemplate.'user.withdraw.add_account', compact('method'));
    }

    public function withdrawSaveMethod(Request $request)
    {
        $rules = ['name'=>'required','method_id'=>'required','currency_id'=>'required'];
        $storeHelper = $this->storeHelper($request, $rules);
        $this->validate($request, $storeHelper['rules']);
        $userMethod = new UserWithdrawMethod();
        $userMethod->name =$request->name;
        $userMethod->user_id = userGuard()['user']->id;
        $userMethod->user_type = userGuard()['type'];
        $userMethod->method_id = $request->method_id;
        $userMethod->currency_id = $request->currency_id;
      //  $userMethod->user_data = $storeHelper['user_data'];
        $userMethod->save();
        $withdraw_method = WithdrawMethod::where('id', $request->method_id)->first();
        $html = '';
        foreach($withdraw_method->MyWithdrawMethod() as $user_account){
            $html .= view($this->activeTemplate.'user.withdraw.account', compact('user_account', 'withdraw_method'))->render();
        }
        return response()->json(['html' => $html]);
    }

    public function withdrawDeleteMethod(Request $request)
    {
        UserWithdrawMethod::where('id', $request->id)->delete();
    }
}
