<?php

namespace App\Http\Controllers;

use App\Http\Traits\ApiPaymentProcess;
use App\Models\ApiPayment;
use App\Models\Currency;
use App\Models\Merchant;
use App\Models\Transaction;
use App\Models\TransactionCharge;
use App\Models\User;
use App\Models\Wallet;
use Carbon\Carbon;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\ValidationException;



class GetPaymentController extends Controller
{
    use ApiPaymentProcess;

    protected $paymentType = 'live';

    public function __construct(){
        $this->activeTemplate = activeTemplate();
    }

    public function checkValidCode($apiPayment, $code, $add_min = 10000)
    {
        if (!$code) return false;
        if (!$apiPayment->ver_code_at) return false;
        if (Carbon::parse($apiPayment->ver_code_at)->addMinutes($add_min) < Carbon::now()) return false;
        if ($apiPayment->ver_code !== $code) return false;
        return true;
    }


    public function checkEmail(Request $request)
    {
        $validator = Validator::make($request->all(),[
            'email' => 'required'
        ]);
        if($validator->fails()) {
            return $this->notify('email_validation');
        }

        $user = User::where('email',$request->email)->first();
        if(!$user){
            return $this->notify('email_check');
        }

        $apiPayment              = $this->getPaymentInfo();
        $apiPayment->ver_code    = verificationCode(6);
        $apiPayment->ver_code_at = Carbon::now();
        $apiPayment->payer_id    = $user->id;
        $apiPayment->save();

        sendEmail($user, 'PAYMENT_VER_CODE', [
            'code' => $apiPayment->ver_code
        ]);

        return $this->notify('email_check_done');

    }

    public function sendVerifyCode()
    {
        $pageTitle ="Verify Payment";
        $apiPayment = $this->getPaymentInfo();
        if ($this->checkValidCode($apiPayment, $apiPayment->ver_code, 2)) {
            $target_time = Carbon::parse($apiPayment->ver_code_at)->addMinutes(2)->timestamp;
            $delay = $target_time - time();
            throw ValidationException::withMessages(['resend' => 'Please Try after ' . $delay . ' Seconds']);
        }
        if (!$this->checkValidCode($apiPayment, $apiPayment->ver_code)) {
            $apiPayment->ver_code    = verificationCode(6);
            $apiPayment->ver_code_at = Carbon::now();
            $apiPayment->save();
        } else {
            $apiPayment->ver_code    = $apiPayment->ver_code;
            $apiPayment->ver_code_at = Carbon::now();
            $apiPayment->save();
        }
        sendEmail($apiPayment->payer, 'PAYMENT_VER_CODE', [
            'code' => $apiPayment->ver_code
        ]);

        if($this->paymentType == 'live'){
        	$verifyRoute = route('confirm.payment');
        }else{
        	$verifyRoute = route('test.confirm.payment');
        }
        return view($this->activeTemplate.'api_payment.verify_payment',compact('pageTitle','apiPayment','verifyRoute'));

    }

    public function verifyPaymentConfirm(Request $request)
    {
        $validator = Validator::make($request->all(),[
            'code'      => 'required',
        ]);

        if($validator->fails()) {
            return $this->notify('code_validation');
        }

        $apiPayment = $this->getPaymentInfo();

        if($request->code != $apiPayment->ver_code){
            return $this->notify('code_not_match');
        }

        $payer = User::find($apiPayment->payer_id);
        if(!$payer){
            return $this->notify('user_not_found');
        }

        $payerWallet = Wallet::hasCurrency()->where('user_type','USER')->where('user_id',$payer->id)->where('currency_id',$apiPayment->currency_id)->first();
        if(!$payerWallet){
            return $this->notify('wallet_not_found');
        }

        $merchant = Merchant::find($apiPayment->merchant_id);
        if(!$merchant){
            return $this->notify('merchant_not_found');
        }

        $merchantWallet = Wallet::hasCurrency()->where('user_type','MERCHANT')->where('user_id',$merchant->id)->where('currency_id',$apiPayment->currency_id)->first();
        if(!$merchantWallet){
            $merchantWallet = new Wallet();
            $merchantWallet->user_id = $merchant->id;
            $merchantWallet->user_type = 'MERCHANT';
            $merchantWallet->currency_id = $payerWallet->currency_id;
            $merchantWallet->currency_code = $payerWallet->currency->currency_code;
            $merchantWallet->save();
        }

        if($apiPayment->amount  > $payerWallet->balance){
            return $this->notify('insuf_balance');
        }

        $paymentCharge = TransactionCharge::where('slug','api_charge')->first();
        if(!$paymentCharge){
            return $this->notify('charge_not_found');
        }

        $rate           = @$apiPayment->curr->rate;
        $fixedCharge    = currencyConverter($paymentCharge->fixed_charge,$rate);
        $totalCharge = chargeCalculator($apiPayment->amount,$paymentCharge->percent_charge,$fixedCharge);

        $cap = currencyConverter($paymentCharge->cap,$rate);
        if($paymentCharge->cap != -1 && $totalCharge > $cap){
            $totalCharge = $cap;
        }

        $payerWallet->balance -= $apiPayment->amount;
        $payerWallet->save();

        $payerTrx                    = new Transaction();
        $payerTrx->user_id           = $payer->id;
        $payerTrx->user_type         = 'USER';
        $payerTrx->wallet_id         = $payerWallet->id;
        $payerTrx->currency_id       = $payerWallet->currency_id;
        $payerTrx->amount            = $apiPayment->amount;
        $payerTrx->post_balance      = $payerWallet->balance;
        $payerTrx->charge            =  0;
        $payerTrx->trx_type          = '-';
        $payerTrx->operation_type    = 'make_payment';
        $payerTrx->details           = 'Payment successful to';
        $payerTrx->receiver_id       = $merchant->id;
        $payerTrx->receiver_type     = 'MERCHANT';
        $payerTrx->trx               =  $apiPayment->trx;
        $payerTrx->save();

        $merchantWallet->balance += ($apiPayment->amount - $totalCharge);
        $merchantWallet->save();

        $merchantTrx                  = new Transaction();
        $merchantTrx->user_id         = $merchant->id;
        $merchantTrx->user_type       = 'MERCHANT';
        $merchantTrx->wallet_id       = $merchantWallet->id;
        $merchantTrx->currency_id     = $merchantWallet->currency_id;
        $merchantTrx->amount          = $apiPayment->amount;
        $merchantTrx->post_balance    = $merchantWallet->balance;
        $merchantTrx->charge          = $totalCharge;
        $merchantTrx->trx_type        = '+';
        $merchantTrx->operation_type  = 'make_payment';
        $merchantTrx->details         = 'Payment successful from';
        $merchantTrx->receiver_id     =  $payer->id;
        $merchantTrx->receiver_type   = 'USER';
        $merchantTrx->trx             =  $apiPayment->trx;
        $merchantTrx->save();

        $apiPayment->status = 1;
        $apiPayment->save();

        $customKey = $apiPayment->amount.$apiPayment->identifier;
        curlPostContent($apiPayment->ipn_url,[
            'status'     => 'success',
            'signature' => strtoupper(hash_hmac('sha256', $customKey , $merchant->secret_api_key)),
            'identifier' => $apiPayment->identifier,
            'data' => [
                'payment_trx' =>  $apiPayment->trx,
                'amount'      => $apiPayment->amount,
                'account_holder'   => @$apiPayment->payer->fullname,
                'payment_type'   => 'hosted',
                'payment_timestamp' => $apiPayment->created_at,
                'charge' => $totalCharge,
                'currency' => [
                    'code'   => @$apiPayment->curr->currency_code,
                    'symbol' => @$apiPayment->curr->currency_symbol,

                ]
            ],

         ]);

         notify($merchant,'MERCHANT_PAYMENT',[
             'amount' => showAmount($apiPayment->amount,$apiPayment->curr),
             'curr_code' => @$apiPayment->curr->currency_code,
             'customer_name' => @$apiPayment->payer->fullname,
             'charge' =>  $totalCharge,
             'trx' => $apiPayment->trx,
             'time' => showDateTime($apiPayment->created_at,'d M Y @ g:i a'),
             'balance' => showAmount($merchantWallet->balance,$apiPayment->curr)
         ]);

        return [
            'error'=>'no',
            'redirect_url'=>$apiPayment->success_url
         ];

   }

}
