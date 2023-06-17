<?php

namespace App\Http\Controllers\Gateway\g111;

use App\Deposit;
use App\ExpressPayment;
use App\Http\Controllers\Gateway\PaymentController;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use StripeJS\StripeJS;
use Auth;
use Session;
require_once('stripe-php/init.php');

class ProcessController extends Controller
{

    /*
     * StripeJS Gateway
     */
    public static function process($deposit){
        $StripeJSAcc = json_decode($deposit->gateway_currency()->parameter);
        $val['key'] = $StripeJSAcc->publishable_key;
        $val['name'] = (Auth::user()) ? Auth::user()->username : '';
        $val['description'] = "Payment with Stripe";
        $val['amount'] = round($deposit->final_amo*100,2);
        $val['currency'] = $deposit->method_currency;
        $send['val'] = $val;
        $send['deposit'] = $deposit;
        $send['src'] ="https://checkout.stripe.com/checkout.js";

        if($deposit->api_id == 0 && $deposit->invoice_id == 0 ){
            $send['view'] = 'payment.g111';
        }else{
            $send['view'] = 'apiPayment.g111';
        }

        $send['method'] = 'post';
        $send['url'] = route('ipn.g111');
        return json_encode($send);
    }

    public static function apiPay($trx){

        $trx = str_replace($_ENV['APP_KEY'],'',base64_decode($trx));

        $deposit = Deposit::where('trx', $trx)->orderBy('id', 'DESC')->first();
        if(!$deposit){
            $notify[] = ['error', 'Invalid Request.'];
            return redirect()->route('home')->withNotify($notify);
        }
        if($deposit->status == 1){
            $notify[] = ['error', 'Invalid Request.'];
            return redirect()->route('home')->withNotify($notify);
        }


        $StripeJSAcc = json_decode($deposit->gateway_currency()->parameter);
        $val['key'] = $StripeJSAcc->publishable_key;
        $val['name'] = (Auth::user()) ? Auth::user()->username : '';
        $val['description'] = "Payment with Stripe";
        $val['amount'] = round($deposit->final_amo*100,2);
        $val['currency'] = $deposit->method_currency;
        $send['val'] = $val;
        $send['deposit'] = $deposit;
        $send['src'] ="https://checkout.stripe.com/checkout.js";

        $send['view'] = 'apiPayment.g111';

        $send['method'] = 'post';
        $send['url'] = route('ipn.api.g111',[$deposit->trx]);

        $page_title = 'StripeJs Payment';

        return view(activeTemplate().'apiPayment.g111-mobile',$send,compact('page_title'));

    }



    /*
     * StripeJS js ipn
     */



    public function ipn(Request $request){

        $track = Session::get('Track');
        $data = Deposit::where('trx', $track)->orderBy('id', 'DESC')->first();

        if($data && $data->status == 1){
            $notify[] = ['error', 'Invalid Request.'];
        }
        $StripeJSAcc = json_decode($data->gateway_currency()->parameter);

        StripeJS::setApiKey($StripeJSAcc->secret_key);

        $customer = \StripeJS\Customer::create([
            'email' => $request->stripeEmail,
            'source' => $request->stripeToken,
        ]);

        $charge = \StripeJS\Charge::create([
            'customer' => $customer->id,
            'description' => 'Payment with Stripe',
            'amount' => round($data->final_amo* 100,2),
            'currency' => $data->method_currency,
        ]);

        if ($charge['status'] == 'succeeded') {
            PaymentController::userDataUpdate($data);
            $notify[] = ['success', 'Transaction was successful.'];
            if($data->api_id != 0 ){
                $express =  ExpressPayment::find($data->api_id);
                return redirect(json_decode($express->all_data)->success_url);
            }
        }

        if($data->api_id == 0 && $data->invoice_id == 0 ){
            return redirect()->route('user.deposit')->withNotify($notify);
        }else if($data->invoice_id != 0 ){
            return redirect()->route('invoice.initiate.error')->with('success','Payment Successfully Completed');
        }else if($data->api_id != 0 ){
            $express =  ExpressPayment::find($data->api_id);
            return redirect(json_decode($express->all_data)->cancel_url);
        }

    }

}
