<?php

namespace App\Http\Controllers\Admin;

use App\Models\Deposit;
use App\Models\Gateway;
use App\Models\GeneralSetting;
use App\Http\Controllers\Controller;
use App\Models\Agent;
use App\Models\Transaction;
use App\Models\User;
use App\Models\Wallet;
use Carbon\Carbon;
use Illuminate\Http\Request;

class DepositController extends Controller
{
    protected $depoRelations = ['user', 'gateway','agent'];

    public function pending()
    {
        $pageTitle = 'Pending Deposits';
        $emptyMessage = 'No pending deposits.';
        $deposits = Deposit::where('method_code', '>=', 1000)->where('status', 2)->with($this->depoRelations)->orderBy('id','desc')->paginate(getPaginate());
        return view('admin.deposit.log', compact('pageTitle', 'emptyMessage', 'deposits'));
    }


    public function approved()
    {
        $pageTitle = 'Approved Deposits';
        $emptyMessage = 'No approved deposits.';
        $deposits = Deposit::where('method_code','>=',1000)->where('status', 1)->with($this->depoRelations)->orderBy('id','desc')->paginate(getPaginate());
        return view('admin.deposit.log', compact('pageTitle', 'emptyMessage', 'deposits'));
    }

    public function successful()
    {
        $pageTitle = 'Successful Deposits';
        $emptyMessage = 'No successful deposits.';
        $deposits = Deposit::where('status', 1)->with($this->depoRelations)->orderBy('id','desc')->paginate(getPaginate());
        return view('admin.deposit.log', compact('pageTitle', 'emptyMessage', 'deposits'));
    }

    public function rejected()
    {
        $pageTitle = 'Rejected Deposits';
        $emptyMessage = 'No rejected deposits.';
        $deposits = Deposit::where('method_code', '>=', 1000)->where('status', 3)->with($this->depoRelations)->orderBy('id','desc')->paginate(getPaginate());
        return view('admin.deposit.log', compact('pageTitle', 'emptyMessage', 'deposits'));
    }

    public function deposit()
    {
        $pageTitle = 'Deposit History';
        $emptyMessage = 'No deposit history available.';
        $deposits = Deposit::with($this->depoRelations)->where('status','!=',0)->orderBy('id','desc')->paginate(getPaginate());

        $depositData = Deposit::where('status','!=',0)->groupBy('currency_id')->selectRaw('sum(amount) as amount,currency_id,status,charge')->with('curr')
        ->get();

        $successful = 0;
        $pending = 0;
        $rejected = 0;
        foreach($depositData as $depo){
            if($depo->status == 1){
                $successful += $depo->amount * $depo->curr->rate;
            }
            if($depo->status == 2){
                $pending += $depo->amount * $depo->curr->rate;
            }
            if($depo->status == 3){
                $rejected += $depo->amount * $depo->curr->rate;
            }
        }

        return view('admin.deposit.log', compact('pageTitle', 'emptyMessage', 'deposits','successful','pending','rejected'));
    }

    public function depositViaMethod($method,$type = null){
        $method = Gateway::where('alias',$method)->firstOrFail();
        if ($type == 'approved') {
            $pageTitle = 'Approved Payment Via '.$method->name;
            $deposits = Deposit::where('method_code','>=',1000)->where('method_code',$method->code)->where('status', 1)->orderBy('id','desc')->with($this->depoRelations);
        }elseif($type == 'rejected'){
            $pageTitle = 'Rejected Payment Via '.$method->name;
            $deposits = Deposit::where('method_code','>=',1000)->where('method_code',$method->code)->where('status', 3)->orderBy('id','desc')->with($this->depoRelations);

        }elseif($type == 'successful'){
            $pageTitle = 'Successful Payment Via '.$method->name;
            $deposits = Deposit::where('status', 1)->where('method_code',$method->code)->orderBy('id','desc')->with($this->depoRelations);
        }elseif($type == 'pending'){
            $pageTitle = 'Pending Payment Via '.$method->name;
            $deposits = Deposit::where('method_code','>=',1000)->where('method_code',$method->code)->where('status', 2)->orderBy('id','desc')->with($this->depoRelations);
        }else{
            $pageTitle = 'Payment Via '.$method->name;
            $deposits = Deposit::where('status','!=',0)->where('method_code',$method->code)->orderBy('id','desc')->with($this->depoRelations);
        }
        $deposits = $deposits->paginate(getPaginate());
        $methodAlias = $method->alias;
        $emptyMessage = 'No Deposit Found';
        return view('admin.deposit.log', compact('pageTitle', 'emptyMessage', 'deposits','methodAlias'));
    }

    public function search(Request $request, $scope)
    {
        $search = $request->search;
        $emptyMessage = 'No search result was found.';
        $deposits = Deposit::with($this->depoRelations)->where('status','!=',0)->where(function ($q) use ($search) {
            $q->where('trx', 'like', "%$search%")->orWhereHas('user', function ($user) use ($search) {
                $user->where('username', 'like', "%$search%");
            });
        });
        if ($scope == 'pending') {
            $pageTitle = 'Pending Deposits Search';
            $deposits = $deposits->where('method_code', '>=', 1000)->where('status', 2);
        }elseif($scope == 'approved'){
            $pageTitle = 'Approved Deposits Search';
            $deposits = $deposits->where('method_code', '>=', 1000)->where('status', 1);
        }elseif($scope == 'rejected'){
            $pageTitle = 'Rejected Deposits Search';
            $deposits = $deposits->where('method_code', '>=', 1000)->where('status', 3);
        }else{
            $pageTitle = 'Deposits History Search';
        }

        $deposits = $deposits->paginate(getPaginate());
        $pageTitle .= '-' . $search;

        return view('admin.deposit.log', compact('pageTitle', 'search', 'scope', 'emptyMessage', 'deposits'));
    }

    public function dateSearch(Request $request,$scope = null){
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
            return redirect()->route('admin.deposit.list')->withNotify($notify);
        }
        if ($end && !preg_match($pattern,$end)) {
            $notify[] = ['error','Invalid date format'];
            return redirect()->route('admin.deposit.list')->withNotify($notify);
        }


        if ($start) {
            $deposits = Deposit::where('status','!=',0)->whereDate('created_at',Carbon::parse($start));
        }
        if($end){
            $deposits = Deposit::where('status','!=',0)->whereDate('created_at','>=',Carbon::parse($start))->whereDate('created_at','<=',Carbon::parse($end));
        }
        if ($request->method) {
            $method = Gateway::where('alias',$request->method)->firstOrFail();
            $deposits = $deposits->where('method_code',$method->code);
        }
        if ($scope == 'pending') {
            $deposits = $deposits->where('method_code', '>=', 1000)->where('status', 2);
        }elseif($scope == 'approved'){
            $deposits = $deposits->where('method_code', '>=', 1000)->where('status', 1);
        }elseif($scope == 'rejected'){
            $deposits = $deposits->where('method_code', '>=', 1000)->where('status', 3);
        }
        $deposits = $deposits->with($this->depoRelations)->orderBy('id','desc')->paginate(getPaginate());
        $pageTitle = ' Deposits Log';
        $emptyMessage = 'No Deposit Found';
        $dateSearch = $search;
        return view('admin.deposit.log', compact('pageTitle', 'emptyMessage', 'deposits','dateSearch','scope'));
    }

    public function details($id)
    {
        $general = GeneralSetting::first();
        $deposit = Deposit::where('id', $id)->with($this->depoRelations)->firstOrFail();
        if($deposit->user_type == 'USER'){
            $user = User::find($deposit->user_id);
        } else if($deposit->user_type == 'AGENT'){
            $user = Agent::find($deposit->user_id);
        }
        $pageTitle = $user->username.' requested ' . showAmount($deposit->amount,$general->currency) . ' '.$general->cur_text;
        $details = ($deposit->detail != null) ? json_encode($deposit->detail) : null;
        return view('admin.deposit.detail', compact('pageTitle', 'deposit','details'));
    }


    public function approve(Request $request)
    {
        $request->validate(['id' => 'required|integer']);
        $deposit = Deposit::where('id',$request->id)->where('status',2)->firstOrFail();
        $deposit->status = 1;
        $deposit->save();

        if($deposit->user_type == 'USER'){
            $user = User::find($deposit->user_id);
        } else if($deposit->user_type == 'AGENT'){
            $user = Agent::find($deposit->user_id);
        }
        $wallet = Wallet::find($deposit->wallet_id);
        $wallet->balance += $deposit->amount*$deposit->rate;
        $wallet->save();

        $userTrx = new Transaction();
        $userTrx->user_id = $deposit->user_id;
        $userTrx->user_type = $deposit->user_type;
        $userTrx->currency_id = $deposit->wallet->currency_id;
        $userTrx->before_charge = $deposit->amount;
        $userTrx->amount = $deposit->amount*$deposit->rate;
        $userTrx->post_balance =  $wallet->balance;
        $userTrx->charge = 0;
        $userTrx->charge_type = '+';
        $userTrx->trx_type = '+';
        $userTrx->operation_type = 'add_money';
        $userTrx->details = 'Added money via manual gateway';
        $userTrx->trx = $deposit->trx;
        $userTrx->save();

        notify($user, 'DEPOSIT_APPROVE', [
            'method_name' => $deposit->gatewayCurrency()->name,
            'method_currency' => $deposit->method_currency,
            'method_amount' => showAmount($deposit->final_amo,getCurrency($deposit->method_currency)),
            'amount' => showAmount($deposit->amount,$deposit->curr),
            'charge' => showAmount($deposit->charge,$deposit->curr),
            'currency' => $deposit->curr->currency_code,
            'rate' => showAmount($deposit->rate,$deposit->curr),
            'trx' => $deposit->trx,
            'post_balance' => showAmount($wallet->balance,$deposit->curr)
        ]);
        $notify[] = ['success', 'Deposit request has been approved.'];

        return redirect()->route('admin.deposit.pending')->withNotify($notify);
    }

    public function reject(Request $request)
    {

        $request->validate([
            'id' => 'required|integer',
            'message' => 'required|max:250'
        ]);
        $deposit = Deposit::where('id',$request->id)->where('status',2)->firstOrFail();
        $deposit->admin_feedback = $request->message;
        $deposit->status = 3;
        $deposit->save();

        if($deposit->user_type == 'USER'){
            $user = User::find($deposit->user_id);
        } else if($deposit->user_type == 'AGENT'){
            $user = Agent::find($deposit->user_id);
        }

        notify($user, 'DEPOSIT_REJECT', [
            'method_name' => $deposit->gatewayCurrency()->name,
            'method_currency' => $deposit->method_currency,
            'method_amount' => showAmount($deposit->final_amo,getCurrency($deposit->method_currency)),
            'amount' => showAmount($deposit->amount,$deposit->curr),
            'charge' => showAmount($deposit->charge,$deposit->curr),
            'currency' => $deposit->curr->currency_code,
            'rate' => showAmount($deposit->rate,$deposit->curr),
            'trx' => $deposit->trx,
            'rejection_message' => $request->message
        ]);

        $notify[] = ['success', 'Deposit request has been rejected.'];
        return  redirect()->route('admin.deposit.pending')->withNotify($notify);

    }
}
