<?php
class InstaForex
{
    private $account;
    private $password;
    public $soap_url = 'http://client-api.instaforex.org/SoapServices/Umbrella.svc?wsdl';
    public $client;

    public function __construct($account, $password)
    {
        $this->account = $account;
        $this->password = $password;
        $this->client = new SoapClient($this->soap_url);
    }

    public function getBalance()
    {
        $params = array(
            'account' => array(
                'Login' => $this->account,
                'Password' => $this->password
            )
        );
        try {
            $data = $this->client->RequestBalance($params);
            return $data->RequestBalanceResult ?? false;
        }
        catch (SoapFault $fault){
            return false;
        }
    }

    public function sendTransfer($amount,$to_account, $transaction_id)
    {
        $params = array(
            'request'=> array(
                'Amount'=>$amount,
                'TargetAccount'=>$to_account,
                'TransactionId'=> $transaction_id
            ),
            'account' => array(
                'Login'=>$this->account,
                'Password'=>$this->password
            )
        );
        try
        {
            $data = $this->client->SendTransfer($params);
            return 'success';
        }
        catch(SoapFault $fault)
        {
            return $fault->detail->WcfApiException->Description;
        }
    }

    public function status($transaction_id)
    {
        $params = array(
            'clientTransactionId' => $transaction_id,
            'account' => array(
                'Login' => $this->account,
                'Password' => $this->password
            )
        );
        try {
            $data = $this->client->RequestTransfer($params);
            if(isset($data->RequestTransferResult)){
                return (array)$data->RequestTransferResult;
            }
            else return false;
        }
        catch(SoapFault $fault){
            return $fault->faultstring;
        }
    }
}
