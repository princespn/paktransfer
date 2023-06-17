<?php

namespace App\Http\Controllers\Gateway\Jazzcash;

use App\Models\Deposit;
use App\Models\GatewayCurrency;
use App\Http\Controllers\Controller;
use App\Http\Controllers\Gateway\PaymentController;
use Auth;
use Illuminate\Http\Request;

class ProcessController extends Controller
{
    /*
     * Jazzcash
     */

     public static function process($deposit)
    {
        $JazzcashAcc = json_decode($deposit->gatewayCurrency()->gateway_parameter);

        $val['pp_Version'] = '1.1';
        $val['pp_TxnType'] = 'MWALLET';
        $val['pp_Language'] = 'EN';
        $val['pp_MerchantID'] = 'MC29442';
        $val['pp_SubMerchantID'] = '';
        $val['pp_Password'] = '28u85tf0yf';
        $val['pp_BankID'] = '';
		$val['pp_ProductID'] = '';
		$val['pp_TxnRefNo'] = $deposit->trx;
		$val['pp_Amount'] = round($deposit->final_amo,2);
		$val['pp_TxnCurrency'] = 'PKR';
		$val['pp_TxnDateTime'] = '';
		$val['pp_BillReference'] = '';
		$val['pp_Description'] = '';
		$val['pp_TxnExpiryDateTime'] = '';
		$val['pp_ReturnURL'] = '';
		$val['pp_SecureHash'] = '';
		$val['ppmpf_1'] = '1';
		$val['ppmpf_2'] = '2';
		$val['ppmpf_3'] = '3';
		$val['ppmpf_4'] = '4';
		$val['ppmpf_5'] = '5';
        $send['val'] = $val;
        $send['view'] = gatewayView('redirect');
        $send['method'] = 'post';
        $send['url'] = 'https://sandbox.jazzcash.com.pk/CustomerPortal/TransactionManagement/TransactionSelection';
        return json_encode($send);
    }

    public function ipn(Request $request)
    {
        
    	$gateway = GatewayCurrency::where('gateway_alias','Cashmaal')->where('currency',$request->currency)->first();
        $IPN_key=json_decode($gateway->gateway_parameter)->ipn_key;
        $web_id=json_decode($gateway->gateway_parameter)->web_id;

        
        $deposit = Deposit::where('trx', $_POST['order_id'])->orderBy('id', 'DESC')->first();
        if ($request->ipn_key != $IPN_key && $web_id != $request->web_id) {
        	$notify[] = ['error','Data invalide'];
        	return redirect()->route(gatewayRedirectUrl())->withNotify($notify);
        }

        if ($request->status == 2) {
        	$notify[] = ['error','Payment in pending'];
        	return redirect()->route(gatewayRedirectUrl())->withNotify($notify);
        }

        if ($request->status != 1) {
        	$notify[] = ['error','Data invalide'];
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
