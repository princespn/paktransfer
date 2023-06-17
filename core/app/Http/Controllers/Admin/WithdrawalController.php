<?php

namespace App\Http\Controllers\Admin;

use Carbon\Carbon;
use App\Models\User;
use App\Models\Wallet;
use App\Models\Withdrawal;
use App\Models\Transaction;
use Illuminate\Http\Request;
use App\Models\GeneralSetting;
use App\Models\WithdrawMethod;
use App\Http\Controllers\Controller;
use App\Models\Agent;
use App\Models\Merchant;

class WithdrawalController extends Controller
{
    protected $relations = ['user','merchant','agent','method','curr','wallet'];

    public function pending()
    {
        $pageTitle = 'Pending Withdrawals';
        $withdrawals = Withdrawal::pending()->with($this->relations)->orderBy('id','desc')->paginate(getPaginate());
        $emptyMessage = 'No withdrawal found';
        return view('admin.withdraw.withdrawals', compact('pageTitle', 'withdrawals', 'emptyMessage'));
    }

    public function approved()
    {
        $pageTitle = 'Approved Withdrawals';
        $withdrawals = Withdrawal::approved()->with($this->relations)->orderBy('id','desc')->paginate(getPaginate());
        $emptyMessage = 'No withdrawal found';
        return view('admin.withdraw.withdrawals', compact('pageTitle', 'withdrawals', 'emptyMessage'));
    }

    public function rejected()
    {
        $pageTitle = 'Rejected Withdrawals';
        $withdrawals = Withdrawal::rejected()->with($this->relations)->orderBy('id','desc')->paginate(getPaginate());
        $emptyMessage = 'No withdrawal found';
        return view('admin.withdraw.withdrawals', compact('pageTitle', 'withdrawals', 'emptyMessage'));
    }

    public function log()
    {
        $pageTitle = 'Withdrawals Log';
        $withdrawals = Withdrawal::where('status', '!=', 0)->with($this->relations)->orderBy('id','desc')->paginate(getPaginate());
        $successful = Withdrawal::where('status', 1)->selectRaw("SUM(amount * rate) as totalAmount")->first()->totalAmount ?? 0;
        $pending = Withdrawal::where('status',2)->selectRaw("SUM(amount * rate) as totalAmount")->first()->totalAmount ?? 0;
        $rejected = Withdrawal::where('status',3)->selectRaw("SUM(amount * rate) as totalAmount")->first()->totalAmount ?? 0;
        $emptyMessage = 'No withdrawal history';
        return view('admin.withdraw.withdrawals', compact('pageTitle', 'withdrawals', 'emptyMessage','successful','pending','rejected'));
    }


    public function logViaMethod($methodId,$type = null){
        $method = WithdrawMethod::findOrFail($methodId);
        if ($type == 'approved') {
            $pageTitle = 'Approved Withdrawal Via '.$method->name;
            $withdrawals = Withdrawal::where('status', 1)->with($this->relations)->where('method_id',$method->id)->orderBy('id','desc')->paginate(getPaginate());
        }elseif($type == 'rejected'){
            $pageTitle = 'Rejected Withdrawals Via '.$method->name;
            $withdrawals = Withdrawal::where('status', 3)->with($this->relations)->where('method_id',$method->id)->orderBy('id','desc')->paginate(getPaginate());

        }elseif($type == 'pending'){
            $pageTitle = 'Pending Withdrawals Via '.$method->name;
            $withdrawals = Withdrawal::where('status', 2)->with($this->relations)->where('method_id',$method->id)->orderBy('id','desc')->paginate(getPaginate());
        }else{
            $pageTitle = 'Withdrawals Via '.$method->name;
            $withdrawals = Withdrawal::where('status', '!=', 0)->with($this->relations)->where('method_id',$method->id)->orderBy('id','desc')->paginate(getPaginate());
        }
        $emptyMessage = 'No withdrawal found';
        return view('admin.withdraw.withdrawals', compact('pageTitle', 'withdrawals', 'emptyMessage','method'));
    }


    public function search(Request $request, $scope)
    {
        $search = $request->search;
        $emptyMessage = 'No search result found.';

        $withdrawals = Withdrawal::with(['user', 'method'])->where('status','!=',0)->where(function ($q) use ($search) {
            $q->where('trx', 'like',"%$search%")
                ->orWhereHas('user', function ($user) use ($search) {
                    $user->where('username', 'like',"%$search%");
                });
        });

        if ($scope == 'pending') {
            $pageTitle = 'Pending Withdrawal Search';
            $withdrawals = $withdrawals->where('status', 2);
        }elseif($scope == 'approved'){
            $pageTitle = 'Approved Withdrawal Search';
            $withdrawals = $withdrawals->where('status', 1);
        }elseif($scope == 'rejected'){
            $pageTitle = 'Rejected Withdrawal Search';
            $withdrawals = $withdrawals->where('status', 3);
        }else{
            $pageTitle = 'Withdrawal History Search';
        }

        $withdrawals = $withdrawals->paginate(getPaginate());
        $pageTitle .= ' - ' . $search;

        return view('admin.withdraw.withdrawals', compact('pageTitle', 'emptyMessage', 'search', 'scope', 'withdrawals'));
    }

    public function dateSearch(Request $request,$scope){
        $search = $request->date;
        if (!$search) {
            return back();
        }
        $date = explode('-',$search);
        $start = @$date[0];
        $end = @$date[1];

        // date validation
        $pattern = "/\d{2}\/\d{2}\/\d{4}/";
        if ($start && !preg_match($pattern,$start)) {
            $notify[] = ['error','Invalid date format'];
            return redirect()->route('admin.withdraw.log')->withNotify($notify);
        }
        if ($end && !preg_match($pattern,$end)) {
            $notify[] = ['error','Invalid date format'];
            return redirect()->route('admin.withdraw.log')->withNotify($notify);
        }


        if ($start) {
            $withdrawals = Withdrawal::where('status','!=',0)->whereDate('created_at',Carbon::parse($start));
        }
        if($end){
            $withdrawals = Withdrawal::where('status','!=',0)->whereDate('created_at','>=',Carbon::parse($start))->whereDate('created_at','<=',Carbon::parse($end));
        }
        if ($request->method) {
            $method = WithdrawMethod::findOrFail($request->method);
            $withdrawals = $withdrawals->where('method_id',$method->id);
        }

        if ($scope == 'pending') {
            $withdrawals = $withdrawals->where('status', 2);
        }elseif($scope == 'approved'){
            $withdrawals = $withdrawals->where('status', 1);
        }elseif($scope == 'rejected') {
            $withdrawals = $withdrawals->where('status', 3);
        }

        $withdrawals = $withdrawals->with(['user', 'method'])->paginate(getPaginate());
        $pageTitle = 'Withdraw Log';
        $emptyMessage = 'No Withdrawals Found';
        $dateSearch = $search;
        return view('admin.withdraw.withdrawals', compact('pageTitle', 'emptyMessage', 'dateSearch', 'withdrawals','scope'));


    }

    public function details($id)
    {
        $general = GeneralSetting::first();
        $withdrawal = Withdrawal::where('id',$id)->where('status', '!=', 0)->with($this->relations)->firstOrFail();
        if($withdrawal->user){
            $username = $withdrawal->user->username;
        } else if($withdrawal->agent) {
            $username = $withdrawal->agent->username;
        } else {
            $username = $withdrawal->merchant->username;
        }
        $pageTitle = $username.' Withdraw Requested ' . showAmount($withdrawal->amount,$withdrawal->curr) . ' '.$withdrawal->curr->currency_code;
        $details = $withdrawal->withdraw_information ? json_encode($withdrawal->withdraw_information) : null;

        $methodImage =  getImage(imagePath()['withdraw']['method']['path'].'/'. $withdrawal->method->image,'800x800');

        return view('admin.withdraw.detail', compact('pageTitle', 'withdrawal','details','methodImage'));
    }

    public function approve(Request $request)
    {
        $request->validate(['id' => 'required|integer']);
        $withdraw = Withdrawal::where('id',$request->id)->where('status',2)->with('user')->firstOrFail();
        $withdraw->status = 1;
        $withdraw->admin_feedback = $request->details;
        $withdraw->save();
        $userType = strtolower($withdraw->user_type);
        $user = $withdraw->$userType;

        notify($user, 'WITHDRAW_APPROVE', [
            'method_name' => $withdraw->method->name,
            'method_currency' => $withdraw->curr->currency_code,
            'method_amount' => showAmount($withdraw->final_amount,$withdraw->curr),
            'amount' => showAmount($withdraw->amount,$withdraw->curr),
            'charge' => showAmount($withdraw->charge,$withdraw->curr),
            'trx' => $withdraw->trx,
            'admin_details' => $request->details
        ]);

        $notify[] = ['success', 'Withdrawal marked as approved.'];
        return redirect()->route('admin.withdraw.pending')->withNotify($notify);
    }


    public function reject(Request $request)
    {
        $general = GeneralSetting::first();
        $request->validate(['id' => 'required|integer']);
        $withdraw = Withdrawal::where('id',$request->id)->where('status',2)->firstOrFail();

        $withdraw->status = 3;
        $withdraw->admin_feedback = $request->details;
        $withdraw->save();

        $wallet = Wallet::find($withdraw->wallet_id);
        $wallet->balance += $withdraw->amount;
        $wallet->save();

        $userType = strtolower($withdraw->user_type);
        $user = $withdraw->$userType;


        $transaction = new Transaction();
        $transaction->user_id = $withdraw->user_id;
        $transaction->user_type = $withdraw->user_type;
        $transaction->currency_id = $withdraw->currency_id;
        $transaction->before_charge = $withdraw->amount;
        $transaction->amount = $withdraw->amount;
        $transaction->post_balance = $wallet->balance;
        $transaction->charge = 0;
        $transaction->charge_type = '+';
        $transaction->trx_type = '+';
        $transaction->operation_type = 'reject_withdraw';
        $transaction->details = 'Refunded from withdrawal rejection';
        $transaction->trx = $withdraw->trx;
        $transaction->save();

        notify($user, 'WITHDRAW_REJECT', [
            'method_name' => $withdraw->method->name,
            'method_currency' => $withdraw->curr->currency_code,
            'method_amount' => showAmount($withdraw->final_amount,$withdraw->curr),
            'amount' => showAmount($withdraw->amount,$withdraw->curr),
            'charge' => showAmount($withdraw->charge,$withdraw->curr),
            'trx' => $withdraw->trx,
            'post_balance' => showAmount($wallet->balance,$withdraw->curr),
            'admin_details' => $request->details
        ]);

        $notify[] = ['success', 'Withdrawal has been rejected.'];
        return redirect()->route('admin.withdraw.pending')->withNotify($notify);
    }

}
