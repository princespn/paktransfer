<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class WithdrawMethod extends Model
{
    protected $guarded = ['id'];
    protected $table = "withdraw_methods";

    protected $casts = [
        'user_data' => 'object',
        'user_guards' => 'object',
        'currencies' => 'object',
    ];

    public function curr()
    {
        return Currency::find($this->currencies)->pluck('currency_code','id','rate');
    }

    public function defaultcurrency()
    {
        return $this->belongsTo(Currency::class,'accepted_currency');
    }

    public function scopeMyWithdrawMethod()
    {
        return UserWithdrawMethod::where('user_type',userGuard()['type'])->where('method_id', $this->id)->where('user_id',userGuard()['user']->id)->whereHas('withdrawMethod',function($query){
            $query->where('status',1)->whereJsonContains('user_guards',userGuard()['guard']);
        })->get();
    }
}
