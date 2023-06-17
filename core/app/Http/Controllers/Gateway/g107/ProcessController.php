<?php

namespace App\Http\Controllers\Gateway\g107;

use App\Deposit;
use App\ExpressPayment;
use App\Http\Controllers\Controller;
use App\Http\Controllers\Gateway\PaymentController;
use Illuminate\Http\Request;
use Auth;

class ProcessController extends Controller
{
    /*
     * PayStack Gateway
     */

    public static function process($deposit){
        $paystackAcc = json_decode($deposit->gateway_currency()->parameter);

        if(Auth::user()){
            $email = Auth::user()->email;
        }elseif ($deposit->invoice_id != 0){
            $email = $deposit->invoice_payment->email;
        }elseif ($deposit->api_id != 0){
            $allData = json_decode($deposit->express_payment->all_data);
            $email = $allData->email;
        }


        $send['key'] = $paystackAcc->public_key;
        $send['email'] = $email;
        $send['amount'] = $deposit->final_amo*100;
        $send['currency'] = $deposit->method_currency;
        $send['ref'] = $deposit->trx;
        $send['deposit'] = $deposit;

        if($deposit->api_id == 0 && $deposit->invoice_id == 0 ){
            $send['view'] = 'payment.g107';
        }else{
            $send['view'] = 'apiPayment.g107';
        }
        return json_encode($send);
    }

    
    public function ipn(Request $request){

        $request->validate([
            'reference' => 'required',
            'paystack-trxref' => 'required',
        ]);

        $track = $request->reference;
        $data = Deposit::where('trx', $track)->orderBy('id', 'DESC')->first();
        $paystackAcc = json_decode($data->gateway_currency()->parameter);
        $secret_key = $paystackAcc->secret_key;

        $result = array();
        //The parameter after verify/ is the transaction reference to be verified
        $url = 'https://api.paystack.co/transaction/verify/' . $track;

        $ch = curl_init();
        curl_setopt($ch, CURLOPT_URL, $url);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($ch, CURLOPT_HTTPHEADER, ['Authorization: Bearer ' . $secret_key]);
        $r = curl_exec($ch);
        curl_close($ch);



        if ($r) {
            $result = json_decode($r, true);

            if ($result) {
                if ($result['data']) {
                    if ($result['data']['status'] == 'success') {

                        $am = $result['data']['amount'];
                        $sam = round($data->final_amo, 2) * 100;

                        if ($am == $sam && $result['data']['currency'] == $data->method_currency  && $data->status == '0') {
                            PaymentController::userDataUpdate($data);

                            if($data->api_id != 0 ){
                                $express =  ExpressPayment::find($data->api_id);
                                return redirect(json_decode($express->all_data)->success_url);
                            }

                            $notify[] = ['success', 'Deposit Successful'];
                        } else {
                            $notify[] = ['error', 'Less Amount Paid. Please Contact With Admin'];
                        }
                    } else {
                        $notify[] = ['error', $result['data']['gateway_response']];
                    }
                } else {
                    $notify[] = ['error', $result['message']];
                }

            } else {
                $notify[] = ['error', 'Something went wrong while executing'];
            }
        } else {
            $notify[] = ['error', 'Something went wrong while executing'];
        }


        if($data->api_id == 0 && $data->invoice_id == 0 ){
            return redirect()->route('user.deposit')->withNotify($notify);
        }else if($data->invoice_id != 0){
            return redirect()->route('invoice.initiate.error')->withNotify($notify);
        }else if($data->api_id != 0){
            $express =  ExpressPayment::find($data->api_id);
            return redirect(json_decode($express->all_data)->cancel_url);
        }

    }





}
