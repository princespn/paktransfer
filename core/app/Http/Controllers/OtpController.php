<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\GeneralSetting;
use App\Models\UserAction;
use Illuminate\Http\Request;

class OtpController extends Controller
{

    public function __construct()
    {
        $this->activeTemplate = activeTemplate();
    }


    public function otpVerification(){
        $pageTitle = 'OTP Verification';
        $userAction = $this->getAction();
        if(!$userAction){
            $notify[] = ['error','Sorry! Unable to Process'];
            return back()->withNotify($notify);
        }
        return view($this->activeTemplate.'otp',compact('pageTitle','userAction'));
    }

    public function otpResend(){
        $general = GeneralSetting::first();
        $userAction = $this->getAction();
        $userAction->otp = verificationCode(6);
        $userAction->send_at = now();
        $userAction->expired_at = now()->addSeconds($general->otp_expiration);
        $userAction->save();

        $funcName = 'send'.ucfirst($userAction->type);
        $funcName(userGuard()['user'],'OTP',[
            'code'=>$userAction->otp
        ]);
        
        return back();
    }

    public function otpVerify(Request $request){
        $request->validate([
            'code'=>'required'
        ]);
        $code = str_replace(' ','',$request->code);
        $userAction = $this->getAction();
        $guard = strtolower(userGuard()['type']);
        if(!$userAction){
            $notify[] = ['error','Sorry! Unable to Process'];
            return back()->withNotify($notify);
        }
        
        if($userAction->type == 'email' || $userAction->type == 'sms'){
            if($userAction->otp != $code){
                $notify[] = ['error','OTP doesn\'t match'];
                return back()->withNotify($notify);
            }
            if($userAction->expired_at < now()){
                $notify[] = ['error','Your OTP has expired'];
                return back()->withNotify($notify);
            }
        }else{
            $user = $userAction->$guard;
            $response = verifyG2fa($user,$code);
            if (!$response) {
                $notify[] = ['error','Verification code doesn\'t match'];
                return back()->withNotify($notify);
            }
        }

        $userAction->used_at = now();
        $userAction->save();
        return redirect($userAction->details->done_route);
    }

    protected function getAction(){
        return UserAction::where('user_id',userGuard()['user']->id)->where('is_otp',1)->where('id',session('action_id'))->first();
    }
}
