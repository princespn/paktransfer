<?php

namespace App\Console\Commands;

use App\Models\Withdrawal;
use Illuminate\Console\Command;

class InstaForexWithdraw extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'instaforex:withdraw';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Automatically Withdraw with InstaForex';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $withdraws = Withdrawal::with('method')->where('status',2)->where('instaforex',1)->where('instaforex_sent',0)->get()->take(10);
        foreach($withdraws as $withdraw){
            $method = $withdraw->method;
            $method_setting = json_decode($method->setting,true);
            $method_setting = $method_setting ? $method_setting : array();
            if(isset($method_setting['umbrella_account']) && !empty($method_setting['umbrella_account']) && isset($method_setting['umbrella_password']) && !empty($method_setting['umbrella_password'])){
                if(isset($withdraw->withdraw_information->instaforex_account_number->field_name) && !empty($withdraw->withdraw_information->instaforex_account_number->field_name)){
                    $instaforex = new \InstaForex($method_setting['umbrella_account'], $method_setting['umbrella_password']);
                    $balance = $instaforex->getBalance();
                    if($withdraw->final_amount < $balance) {
                        $finalAmount = (float)$withdraw->final_amount;
                        $transfer = $instaforex->sendTransfer($finalAmount, $withdraw->withdraw_information->instaforex_account_number->field_name, $withdraw->trx);
                        $status = $instaforex->status($withdraw->trx);
                        if ($transfer == 'success') {
                            $withdraw->instaforex_sent = 1;
                            $withdraw->save();
                            var_dump('success');
                        } else {
                            var_dump($withdraw->withdraw_information->instaforex_account_number->field_name);
                            var_dump($finalAmount);
                            var_dump($status);
                            var_dump($balance);
                            var_dump($transfer);
                        }
                    }
                }
            }
            else{

            }
        }
        return 0;
    }
}
