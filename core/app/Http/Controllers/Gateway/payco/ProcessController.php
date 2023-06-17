<?php

namespace App\Http\Controllers\Gateway\payco;
use App\Models\Deposit;
use App\Models\GatewayCurrency;
use App\Http\Controllers\Controller;
use App\Http\Controllers\Gateway\PaymentController;
use Auth;
use Illuminate\Http\Request;
use core\config\payco;



class ProcessController extends Controller
{
    /*
     * Payco
     */

    public static function process($deposit)
    {
        $PaycoAcc = json_decode($deposit->gatewayCurrency()->gateway_parameter);

        $val['desc'] = 'paktransfer';
        $val['curr'] = "$deposit->method_currency";
        $val['amt'] = round($deposit->final_amo,2);
        $val['MID'] = '256180827';
        $val['TID'] = "$deposit->trx";
        $val['MWALLET'] = 'M081709406';
        $val['SIGN'] = hash('sha256',config('payco.SIGN1').round($deposit->final_amo,2).config('payco.SIGN2')."$deposit->trx".config('payco.SIGN3'));
        
        $send['val'] = $val;
        $send['view'] = gatewayView('redirect');
        $send['method'] = 'post';
        $send['url'] = 'https://payments.pay.co/payments';
        return json_encode($send);
    }
        
        public function ipn(Request $request)
        {
        $deposit = Deposit::where('trx', $_POST['TID'])->orderBy('id', 'DESC')->first();
        
        if ($request->status == 2) {
        	$notify[] = ['error','Payment in pending'];
        	return redirect()->route(gatewayRedirectUrl())->withNotify($notify);
        }

		if($_POST['status'] == 1 && $deposit->status == 0 && $_POST['currency'] == $deposit->method_currency ){
			PaymentController::userDataUpdate($deposit->trx);
            $notify[] = ['success', 'Transaction is successful'];
		}else{
			$notify[] = ['error','Payment failed'];
        	return redirect()->route(gatewayRedirectUrl())->withNotify($notify);
		}
		return redirect()->route(gatewayRedirectUrl(true))->withNotify($notify);
    }
    
}

 