<?php

namespace App\Console\Commands;

use App\Models\Withdrawal;
use App\Models\WithdrawMethod;
use GuzzleHttp\Client;
use Illuminate\Console\Command;

class TestMoney extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'test:money';

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
                $wallets = $this->wallets($setting['perfect_account_id'], $setting['perfect_passphrase']);
                $balance = 0;
                if($wallets['status'] == 'success') {
                    foreach ($wallets['wallets'] as $wallet) {
                        if (substr($wallet['account'], 0, 1) == 'U') {
                            $balance = (float)$wallet['balance'];
                        }
                    }
                    var_dump($balance);
                }
            }
        }
    }

    public function wallets($account_id, $passphrase)
    {
        $response = $this->sendRequest('https://perfectmoney.is/acct/balance.asp?AccountID=' . $account_id . '&PassPhrase=' . $passphrase);

        if($response['status'] == 'success'){
            $data = ['wallets' => []];
            foreach($response['result'] as $item)
            {
                if($item[1] != 'ERROR')
                {
                    $data['wallets'][] = [
                        'account' 	=> $item[1],
                        'balance'	=> $item[2]
                    ];
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
}
