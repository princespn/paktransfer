<?php

namespace App\Http\Middleware;

use Closure;
use App\Models\KycForm;
use Illuminate\Support\Facades\Auth;

class Kyc
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        $userKyc = KycForm::where('user_type',userGuard()['type'])->first();
        if ($userKyc->status == 1 && userGuard()['user']->kyc_status == 0 || userGuard()['user']->kyc_status == 2) {
            if(userGuard()['user']->kyc_status == 2){
                $msg = 'Please! wait for your KYC confirmation from system.';
            } else{
                $msg = 'Please! submit your KYC information first.';
            }
            $notify[] = ['error', $msg];
            return redirect(route(strtolower(userGuard()['type']).'.home'))->withNotify($notify);
        }
        return $next($request);
    }
}
