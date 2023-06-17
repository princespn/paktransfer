<?php

return [
    
    'SIGN' => '1223345',
    'desc' => 'paktransfer',
    'curr' => 'USD',
    'amt' =>  '2.53',
    'MID' => '256180827',
    'str' => 'desc'.'curr',
    'TID' => "$deposit->trx",
    'MWALLET' => 'M081709406',
    'SEP' => 'just4',
    'SECRET' => 'Just56fun',
    'SIGN1' => '256180827'.'just4',
    'SIGN2' => 'just4'.'USD'.'just4'.'paktransfer'.'just4',
    'SIGN3' => 'just4'.'M081709406'.'just4'.'Just56fun',
     
    'SIGN' => hash('sha256',$MID.$SEP.sprintf("%1.2f",$amt).$SEP.$curr.$SEP.$desc.$SEP.$TID.$SEP.$MWALLET.$SEP.$SECRET),
    
    'final' => hash('sha256',config('payco.SIGN1').round($deposit->final_amo,2).config('payco.SIGN2')."$deposit->trx".config('payco.SIGN3'))
    
    ];