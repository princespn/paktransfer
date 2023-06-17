<?php

namespace App\Http\Traits;

use App\Models\Deposit;
use App\Models\GeneralSetting;
use App\Models\QRcode;
use App\Models\Transaction;
use App\Models\Wallet;
use App\Models\Withdrawal;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Intervention\Image\Facades\Image;

trait UserPartials{

	public function trxLimit($type){
		$rate = currencyRate();
		$user = $this->user();
		$query = "SUM(amount * $rate) as totalAmount";
		$transactions = $user->transactions()->where('operation_type',$type);
		return [
			'daily'=> $transactions->whereDate('created_at',\Carbon\Carbon::now())->selectRaw($query)->get()->sum('totalAmount'),
			'monthly'=> $transactions->whereMonth('created_at',\Carbon\Carbon::now())->selectRaw($query)->get()->sum('totalAmount'),
		];
	}

	public function trxLog($request){
		$search = $request->search;
		$type = $request->type;
    	$operation = $request->operation;
    	if($type && $type == 'plus_trx'){
	       $type = '+';
	    } else if($type && $type == 'minus_trx'){
	       $type = '-';
	    }
	  
	    $time = $request->time;
	    if($time){
	        if($time == '7days')        $time = 7;
	        else if($time == '15days' ) $time = 15; 
	        else if($time == '1month')  $time = 31; 
	        else if($time == '1year')   $time = 365;
	    }
	    $currency = strtoupper($request->currency);

		$histories = Transaction::where([['user_id',$this->user()->id],['user_type',userGuard()['type']]])
                 ->when($search, function($trx,$search){
                    return  $trx->where('trx',$search);
                 })
                 ->when($type, function($trx,$type){
                    return  $trx->where('trx_type',$type);
                 })
                 ->when($time,function($trx,$time){
                    return  $trx->where('created_at','>=',Carbon::today()->subDays($time));
                 })
                 ->when($operation,function($trx,$operation){
                    return  $trx->where('operation_type',$operation);
                 })
                 ->when($currency,function($trx,$currency){
                    return  $trx->whereHas('currency',function($curr) use($currency){
                        $curr->where('currency_code',$currency);
                    });
                 })
                 ->with('currency')->orderBy('id','DESC')->paginate(getPaginate());
        return $histories;
	}


	public function createQr(){
		 $user = $this->user();
	    $qrCode = $user->qrCode()->first();
	    if(!$qrCode){
	        $qrCode = new QRcode();
	        $qrCode->user_id = $user->id;
	        $qrCode->user_type = userGuard()['type'];
	        $qrCode->unique_code = keyGenerator(15);
	        $qrCode->save();
	    } 
	    return $qrCode;
	}

	public function downLoadQr(){
		 $user = $this->user();
	     $qrCode = $user->qrCode()->first();
		 $general = GeneralSetting::first();
	     $file = cryptoQR($qrCode->unique_code);
	     $filename = $qrCode->unique_code.'.jpg';
	     $template = Image::make('assets/images/qr/'.$general->qr_template);
	     $qrCode = Image::make($file)->opacity(100)->fit(2000,2000);
	     $template->insert($qrCode,'center'); 
	     $template->encode('jpg');
	 
	     $headers = [
	         'Content-Type' => 'image/jpeg',
	         'Content-Disposition' => 'attachment; filename='. $filename,
	     ];
	     return response()->stream(function() use ($template) {
	         echo $template;
	     }, 200, $headers);
	}

	public function kycStyle(){
		 $type = strtolower(userGuard()['type']);
		 $user = $this->user();
	    if($user->kyc_status == 2) {
	        $kyc['bgColor'] = 'bg--warning';
	        $kyc['btnBg'] = 'bg--primary';
	        $kyc['btnTxt'] = 'PENDING';
	        $kyc['iconBg'] = 'text--primary';
	        $kyc['msg'] = "Your information has been submitted for review.";
	        $kyc['route'] = 'javascript:void(0)';
	    }else if($user->kyc_status == 0) {
	        $kyc['bgColor'] = '';
	        $kyc['btnBg'] = '';
	        $kyc['btnTxt'] = 'SUBMIT NOW';
	        $kyc['iconBg'] = 'text--base';
	        $kyc['msg'] = "You have information to submit in verification center.";
	        $kyc['route'] = route( $type.'.kyc');
	    }else if($user->kyc_status == 3) {
	        $kyc['bgColor'] = 'bg--danger';
	        $kyc['btnBg'] = '';
	        $kyc['btnTxt'] = 'RE-SUBMIT';
	        $kyc['iconBg'] = 'text--warning';
	        $kyc['msg'] = "(Rejected) Please provide the correct information.";
	        $kyc['route'] = route( $type.'.kyc');
	    }else{
	        $kyc = null;
	    }
	    return $kyc;
	}

	public function moneyInOut($day = 7){
		$user = $this->user();
		$date = Carbon::today()->subDays($day);
	    $moneyIn = $user->transactions()->whereDate('created_at', '>=', $date)->where('trx_type','+')->with('currency')->get(['amount','currency_id']);
	    $moneyOut = $user->transactions()->whereDate('created_at', '>=', $date)->where('trx_type','-')->with('currency')->get(['amount','currency_id']);

	    $totalMoneyIn = 0;
	    $totalMoneyOut = 0;
	    if(!$moneyIn->isEmpty()){
	        foreach($moneyIn as $inTrx){
	            $in[] =  $inTrx->amount * $inTrx->currency->rate;
	        }
	        $totalMoneyIn = array_sum($in);
	    }
	    if(!$moneyOut->isEmpty()){
	        foreach($moneyOut as $outTrx){
	            $out[] =  $outTrx->amount * $outTrx->currency->rate;
	        }
	        $totalMoneyOut = array_sum($out);
	    }
	    return ['totalMoneyIn'=>$totalMoneyIn, 'totalMoneyOut' => $totalMoneyOut];
	}


	public function totalDeposit(){
		$log = Deposit::where('user_type',userGuard()['type'])->where('user_id',$this->user()->id)->where('status',1)->with('curr')->selectRaw('SUM(amount * rate) as finalAmount')->first();
		return $log->finalAmount;
	}


	public function totalWithdraw(){
		$log = Withdrawal::where('user_type',userGuard()['type'])->where('user_id',$this->user()->id)->where('status',1)->with('curr')->selectRaw('SUM(amount * rate) as finalAmount')->first();
		return $log->finalAmount;
	}

	public function topTransactedWallets(){
		$wallets = Wallet::hasCurrency()->where('user_id',$this->user()->id)->where('user_type',userGuard()['type'])
        ->select(DB::raw('*'))
        ->addSelect(DB::raw('
            (select count(*) 
            from transactions
            where wallet_id = wallets.id) 
            as transactions
        '))
        ->orderBy('transactions','desc');
        return $wallets;
	}

	public function trxGraph(){
		// Transaction Graph
         $report['trx_dates'] = collect([]);
         $report['trx_amount'] = collect([]);
         $rate = currencyRate();
       
         $transactions = Transaction::where('user_type',userGuard()['type'])->where('user_id',$this->user()->id)->where('created_at', '>=', Carbon::now()->subYear())
         ->where('trx_type','+')
         ->selectRaw("SUM(amount * $rate) as totalAmount")
         ->selectRaw("DATE_FORMAT(created_at,'%M-%Y') as dates")
         ->orderBy('created_at')->groupBy('dates')->get();
 
         $transactions->map(function ($trxData) use ($report) {
             $report['trx_dates']->push($trxData->dates);
             $report['trx_amount']->push($trxData->totalAmount);
         });

         return $report;
	}


	protected function user(){
		return userGuard()['user'];
	}




}