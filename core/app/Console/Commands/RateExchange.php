<?php

namespace App\Console\Commands;

use App\Currency;
use App\GatewayCurrency;
use App\WithdrawMethod;
use Illuminate\Console\Command;

class RateExchange extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'rate:exchange';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

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
        $ch = curl_init();
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_URL,'https://api.exchangerate-api.com/v4/latest/USD');
        $json=curl_exec($ch);
        curl_close($ch);

        $exchangeRates = json_decode($json,true);
        if(is_array($exchangeRates) && isset($exchangeRates['rates'])){
            $rates = $exchangeRates['rates'];
            $currencies = Currency::all();
            foreach($currencies as $currency){
                $code = $currency->code;
                if(isset($rates[$code]) && !empty($rates[$code])){
                    $currency->rate = $rates[$code];
                    $currency->save();
                }
            }
            $methods = WithdrawMethod::all();
            foreach($methods as $method){
                $code = $method->currency;
                if(isset($rates[$code]) && !empty($rates[$code])){
                    $method->rate = $rates[$code];
                    $method->save();
                }
            }
            $gateways = GatewayCurrency::all();
            foreach($gateways as $gateway){
                $code = $gateway->currency;
                if($code != 'USD' && isset($rates[$code]) && !empty($rates[$code])){
                    $ratePer = number_format(1/$rates[$code],8);
                    $gateway->rate = $ratePer;
                    $gateway->save();
                }
            }
        }
        return 0;
    }
}
