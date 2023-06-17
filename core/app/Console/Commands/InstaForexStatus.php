<?php

namespace App\Console\Commands;

use App\Models\Withdrawal;
use Illuminate\Console\Command;

class InstaForexStatus extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'instaforex:status';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'check status of withdrawal InstaForex';

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
        $withdraws = Withdrawal::with('method')->where('status',2)->where('instaforex',1)->where('instaforex_sent',1)->get()->take(10);
        foreach ($withdraws as $withdraw){
            $method = $withdraw->method;
            $method_setting = json_decode($method->setting,true);
            $method_setting = $method_setting ? $method_setting : array();
            if(isset($method_setting['umbrella_account']) && !empty($method_setting['umbrella_account']) && isset($method_setting['umbrella_password']) && !empty($method_setting['umbrella_password'])){
                $instaforex = new \InstaForex($method_setting['umbrella_account'], $method_setting['umbrella_password']);
                $status = $instaforex->status($withdraw->trx);
                if($status && is_array($status) && isset($status['State']) && $status['State'] == 'SuccessfullyFinished'){
                    $withdraw->status = 1;
                    $withdraw->admin_feedback = "Deposit Ticket: ".$status['DepositTicket']."\nWithdrawal Ticket: ".$status['WithdrawalTicket']."\n Transaction ID: ".$withdraw->trx;
                    $withdraw->save();
                }
                else{
                    var_dump($status);
                }
            }
        }
        return 0;
    }
}
