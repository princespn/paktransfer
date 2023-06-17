<?php

namespace App\Http\Controllers\Admin;

use App\Models\User;
use App\Models\KycForm;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App\Models\Agent;
use App\Models\Merchant;

class KycController extends Controller
{
    public function manageKyc()
    {
        $pageTitle = "Manage KYC Form";
        $kyc       = KycForm::latest()->get();
        $emptyMessage = "No Data Found";
        return view('admin.kyc.list',compact('pageTitle','kyc','emptyMessage'));
    }
    public function editKyc($userType)
    {
        $pageTitle = "Edit KYC Form";
        $kyc       = KycForm::where('user_type',$userType)->firstOrFail();
        return view('admin.kyc.edit',compact('pageTitle','kyc'));
    }

    public function updateKyc(Request $request)
    {
        $request->validate([
            'field_name.*'   => 'sometimes|required'
        ],
        [
            'field_name.*.required'=>'All form data field is required'
        ]);

        $input_form = [];
        if ($request->has('field_name')) {
            for ($a = 0; $a < count($request->field_name); $a++) {
                $arr = [];
                $arr['field_name'] =  strtolower(str_replace(' ', '_', sanitizedParam($request->field_name[$a])));
                $arr['field_level'] = $request->field_name[$a];
                $arr['type'] = $request->type[$a];
                $arr['validation'] = $request->validation[$a];
                $input_form[$arr['field_name']] = $arr;
            }
        }

        $kyc = KycForm::findOrFail($request->id);
        $kyc->status = $request->status ? 1 : 0;
        $kyc->form_data = $input_form;
        $kyc->save();
        $notify[]=['success','Kyc form updated'];
        return back()->withNotify($notify);
    }

    //user kyc
    public function userPendingKyc()
    {
        $pageTitle = "User Pending KYC's";
        $kycInfo = User::isKyc(2)->paginate(getPaginate());
        $type = 'user';
        $emptyMessage = "No Data Found";
        return view('admin.kyc.kyc_list',compact('pageTitle','kycInfo','emptyMessage','type'));
    }
    public function userApprovedKyc()
    {
        $pageTitle = "User Approved KYC's";
        $kycInfo = User::isKyc(1)->paginate(getPaginate());
        $type = 'user';
        $emptyMessage = "No Data Found";
        return view('admin.kyc.kyc_list',compact('pageTitle','kycInfo','emptyMessage','type'));
    }

    public function userKycDetails($userId)
    {
        $approveAction = route('admin.kyc.info.user.approve');
        $rejectAction = route('admin.kyc.info.user.reject');
        $user =  User::isKyc()->where('id',$userId)->firstOrFail();
        $pageTitle = "KYC Info of $user->username";
        $prevUrl = url()->previous();
        return view('admin.kyc.kyc_details',compact('pageTitle','user','prevUrl','approveAction','rejectAction'));
    }

    public function approveUserKyc(Request $request)
    {
        $user =  User::findOrFail($request->user_id);
        $user->kyc_status = 1;
        $user->save();
        $notify[]=['success','KYC approved successfully'];
        return redirect(route('admin.kyc.info.user.pending'))->withNotify($notify);
    }
    public function rejectUserKyc(Request $request)
    {
        $request->validate([
            'reasons'=>'required'
        ]);
        $user =  User::findOrFail($request->user_id);
        $user->kyc_status = 3;
        $user->kyc_reject_reasons = $request->reasons;
        $user->save();
        $notify[]=['success','KYC has been rejected'];
        return redirect(route('admin.kyc.info.user.pending'))->withNotify($notify);
    }


    //agent kyc
    public function agentPendingKyc()
    {
        $pageTitle = "Agent Pending KYC's";
        $kycInfo = Agent::isKyc(2)->paginate(getPaginate());
        $type = 'agent';
        $emptyMessage = "No Data Found";
        return view('admin.kyc.kyc_list',compact('pageTitle','kycInfo','emptyMessage','type'));
    }
    public function agentApprovedKyc()
    {
        $pageTitle = "User Approved KYC's";
        $kycInfo = Agent::isKyc(2)->paginate(getPaginate());
        $type = 'agent';
        $emptyMessage = "No Data Found";
        return view('admin.kyc.kyc_list',compact('pageTitle','kycInfo','emptyMessage','type'));
    }

    public function agentKycDetails($userId)
    {
        $approveAction = route('admin.kyc.info.agent.approve');
        $rejectAction = route('admin.kyc.info.agent.reject');
        $user =  Agent::isKyc()->where('id',$userId)->firstOrFail();
        $pageTitle = "KYC Info of $user->username";
        $prevUrl = url()->previous();
        return view('admin.kyc.kyc_details',compact('pageTitle','user','prevUrl','approveAction','rejectAction'));
    }

    public function approveAgentKyc(Request $request)
    {
        $user =  Agent::findOrFail($request->user_id);
        $user->kyc_status = 1;
        $user->save();
        $notify[]=['success','KYC approved successfully'];
        return redirect(route('admin.kyc.info.agent.pending'))->withNotify($notify);
    }
    public function rejectAgentKyc(Request $request)
    {
        $request->validate([
            'reasons'=>'required'
        ]);
        $user =  Agent::findOrFail($request->user_id);
        $user->kyc_status = 3;
        $user->kyc_reject_reasons = $request->reasons;
        $user->save();
        $notify[]=['success','KYC has been rejected'];
        return redirect(route('admin.kyc.info.agent.pending'))->withNotify($notify);
    }


   
    //merchant kyc
    public function merchantPendingKyc()
    {
        $pageTitle = "Merchant Pending KYC's";
        $kycInfo = Merchant::isKyc(2)->paginate(getPaginate());
        $type = 'merchant';
        $emptyMessage = "No Data Found";
        return view('admin.kyc.kyc_list',compact('pageTitle','kycInfo','emptyMessage','type'));
    }
    public function merchantApprovedKyc()
    {
        $pageTitle = "Merchant Approved KYC's";
        $kycInfo = Merchant::isKyc(1)->paginate(getPaginate());
        $type = 'merchant';
        $emptyMessage = "No Data Found";
        return view('admin.kyc.kyc_list',compact('pageTitle','kycInfo','emptyMessage','type'));
    }

    public function merchantKycDetails($userId)
    {
        $approveAction = route('admin.kyc.info.merchant.approve');
        $rejectAction = route('admin.kyc.info.merchant.reject');
        $user =  Merchant::isKyc()->where('id',$userId)->firstOrFail();
        $pageTitle = "KYC Info of $user->username";
        $prevUrl = url()->previous();
        return view('admin.kyc.kyc_details',compact('pageTitle','user','prevUrl','approveAction','rejectAction'));
    }

    public function approveMerchantKyc(Request $request)
    {
        $user =  Merchant::findOrFail($request->user_id);
        $user->kyc_status = 1;
        $user->save();
        $notify[]=['success','KYC approved successfully'];
        return redirect(route('admin.kyc.info.merchant.pending'))->withNotify($notify);
    }
    public function rejectMerchantKyc(Request $request)
    {
        $request->validate([
            'reasons'=>'required'
        ]);
        $user =  Merchant::findOrFail($request->user_id);
        $user->kyc_status = 3;
        $user->kyc_reject_reasons = $request->reasons;
        $user->save();
        $notify[]=['success','KYC has been rejected'];
        return redirect(route('admin.kyc.info.merchant.pending'))->withNotify($notify);
    }


}
