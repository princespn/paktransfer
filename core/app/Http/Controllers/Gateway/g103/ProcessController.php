<?php

namespace App\Http\Controllers\Gateway\g103;

use App\Deposit;
use App\ExpressPayment;
use App\GeneralSetting;
use App\Http\Controllers\Gateway\PaymentController;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Stripe\Charge;
use Stripe\Stripe;
use Stripe\Token;
use Validator;
use Illuminate\Support\Facades\Session;
require_once('stripe-php/init.php');

class ProcessController extends Controller
{

    /*
     * Stripe Gateway
     */
    public static function process($deposit){
        $send['track'] = $deposit->trx;
        if($deposit->api_id == 0 && $deposit->invoice_id == 0 ){
            $send['view'] = 'payment.g103';
        }else{
            $send['view'] = 'apiPayment.g103';
        }
        $send['method'] = 'post';
        $send['url'] = route('ipn.g103');
        return json_encode($send);
    }

    public function ipn(Request $request){

        $track = Session::get('Track');
        $data = Deposit::where('trx', $track)->orderBy('id', 'DESC')->first();
        if($data->status == 1){


            if($data->api_id == 0 && $data->invoice_id == 0 ){
                $notify[] = ['error', 'Invalid Request.'];
                return redirect()->route('user.deposit')->withNotify($notify);
            }else if($data->invoice_id != 0 ){
                return redirect()->route('invoice.initiate.error')->with('error','Invalid Request');
            }else if($data->api_id != 0 ){
                return redirect()->route('express.error')->with('error', 'Invalid Request');
            }

        }

        $this->validate($request,[
            'cardNumber' => 'required',
            'cardExpiry' => 'required',
            'cardCVC' => 'required',
        ]);

        $cc = $request->cardNumber;
        $exp = $request->cardExpiry;
        $cvc = $request->cardCVC;

        $exp = $pieces = explode("/", $_POST['cardExpiry']);
        $emo = trim($exp[0]);
        $eyr = trim($exp[1]);
        $cnts = round($data->final_amo, 2) * 100;

        $stripeAcc = json_decode($data->gateway_currency()->parameter);

        Stripe::setApiKey($stripeAcc->secret_key);
        try {
            $token = Token::create(array(
                "card" => array(
                    "number" => "$cc",
                    "exp_month" => $emo,
                    "exp_year" => $eyr,
                    "cvc" => "$cvc"
                )
            ));

            try {
                $charge = Charge::create(array(
                    'card' => $token['id'],
                    'currency' => $data->method_currency,
                    'amount' => $cnts,
                    'description' => 'item',
                ));

                if ($charge['status'] == 'succeeded') {
                    PaymentController::userDataUpdate($data);
                    $notify[] = ['success', 'Payment Success.'];

                    if($data->api_id != 0 ){
                        $express =  ExpressPayment::find($data->api_id);
                        return redirect(json_decode($express->all_data)->success_url);
                    }
                }
            } catch (\Exception $e) {

                $notify[] = ['error', $e->getMessage()];
            }

        } catch (\Exception $e) {

            $notify[] = ['error', $e->getMessage()];
        }

        if($data->api_id == 0 && $data->invoice_id == 0 ){
            return redirect()->route('user.deposit')->withNotify($notify);
        }else if($data->invoice_id != 0 ){
            return redirect()->route('invoice.initiate.error')->withNotify($notify);
        }else if($data->api_id != 0 ){
            $express =  ExpressPayment::find($data->api_id);
            return redirect(json_decode($express->all_data)->cancel_url);
        }
    }


}
