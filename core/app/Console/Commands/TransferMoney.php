<?php

namespace App\Console\Commands;

use App\Models\Withdrawal;
use App\Models\WithdrawMethod;
use GuzzleHttp\Client;
use Illuminate\Console\Command;

class TransferMoney extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'transfer:money';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    protected $client;

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
        $this->client = new Client(['verify' => false]);
    }

    /**
     * Execute the console command.
     *
     * @return int
     */

    public function handle()
    {
        $withdrawMethod = WithdrawMethod::where('type_method',2)->first();
        if($withdrawMethod) {
            $setting = json_decode($withdrawMethod->setting, true);
            if(
                isset($setting['perfect_account_id'])
                && isset($setting['perfect_passphrase'])
                && isset($setting['perfect_wallet'])
                && !empty($setting['perfect_account_id'])
                && !empty($setting['perfect_passphrase'])
                && !empty($setting['perfect_wallet'])
            ) {
                $response = $this->transfer($setting['perfect_account_id'],$setting['perfect_passphrase'],$setting['perfect_wallet'],'U36323918', 450, 'Demo Send');
                var_dump($response);
            }
        }
    }

    public function transfer($account_id, $passphrase, $merchant_id, $account, $amount, $descripion = '', $payment_id = '')
    {

        // trying to open URL to process PerfectMoney Spend request
        $dataQuery = array(
            'AccountID' => trim($account_id),
            'PassPhrase' => trim($passphrase),
            'Payer_Account' => trim($merchant_id),
            'Payee_Account' => trim($account),
            'Amount' => $amount,
        );
        if(!empty($descripion)){
            $dataQuery['Memo'] = trim($descripion);
        }
        if(!empty($payment_id)){
            $dataQuery['PAYMENT_ID'] = trim($payment_id);
        }

        $response = $this->sendRequest('https://perfectmoney.is/acct/confirm.asp?'.http_build_query($dataQuery));
        if($response['status'] == 'success'){
            $data = [];
            foreach($response['result'] as $item)
            {
                if($item[1] != 'ERROR')
                {
                    $data['message'][$item[1]] = $item[2];
                }
                else{
                    $data['error'] = $item[2];
                }
            }
            $data['status'] = 'success';
            return $data;
        }

        return $response;
    }
protected function sendRequest($url, $data = false){
        $response = $this->client->get($url);
        if($response->getStatusCode() == 200){
            $body = $response->getBody()->getContents();
            if(!preg_match_all("/<input name='(.*)' type='hidden' value='(.*)'>/", $body, $result, PREG_SET_ORDER)){
                return ['status' => 'error', 'message' => 'Invalid output'];
            }
            else{
                return ['status' => 'success', 'result' => $result];
            }

        }
        else{
            return ['status' => 'error', 'message' => 'Connection error'];
        }
    }
}

