<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Deposit extends Model
{
    protected $table = 'deposits';
    protected $guarded = ['id'];

    protected $casts = [
        'detail' => 'object'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
    public function agent()
    {
        return  $this->belongsTo(Agent::class,'user_id');
    }
    public function gateway()
    {
        return $this->belongsTo(Gateway::class, 'method_code', 'code');
    }
    public function curr()
    {
        return $this->belongsTo(Currency::class, 'currency_id');
    }

    // scope
    public function scopegatewayCurrency()
    {
        return GatewayCurrency::where('method_code', $this->method_code)->where('currency', $this->method_currency)->first();
    }

    public function scopeBaseCurrency()
    {
        return $this->gateway->crypto == 1 ? 'USD' : $this->method_currency;
    }
    public function convertedCurr()
    {
        return $this->belongsTo(Currency::class,'currency_id');
    }

    public function scopePending()
    {
        return $this->where('status', 2);
    }

    public function wallet()
    {
        return $this->belongsTo(Wallet::class,'wallet_id');
    }
}
