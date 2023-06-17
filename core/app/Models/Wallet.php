<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Wallet extends Model
{
    use HasFactory;
    public function currency()
    {
        return $this->belongsTo(Currency::class,'currency_id');
    }
    public function user()
    {
        return $this->belongsTo(User::class,'user_id');
    }
    public function gateways()
    {
        $code = $this->currency->currency_code;
        return GatewayCurrency::whereHas('method',function($q) use ($code){
            $q->whereJsonContains("supported_currencies->$code",$code)->where('status',1);
        })->where('currency',$code)->with('method')->orderby('method_code')->get();
        
    }

    public function agent()
    {
        return $this->belongsTo(Agent::class,'user_id');
    }
    public function merchant()
    {
        return $this->belongsTo(Merchant::class,'user_id');
    }
    public function transactions()
    {
        return $this->hasMany(Transaction::class,'wallet_id');
    }

    public function scopeHasCurrency(){
        return $this->whereHas('currency',function($query){
            $query->where('status',1);
        });
    }

    public function scopeSelfCreate($filter,$data){
        $this->user_type     = @$data[2] ?? userGuard()['type'];
        $this->user_id       = @$data[3] ?? userGuard()['user']->id;
        $this->currency_id   = $data[0];
        $this->currency_code = $data[1];
        $this->save();
        return $this;
    }

    public function scopeCheckWallet($filter,$data){
        return $this->hasCurrency()->where('user_id',$data['user']->id)->where('user_type',$data['type'])->with('currency');
    }
}


