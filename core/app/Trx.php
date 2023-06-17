<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Trx extends Model
{
    protected $guarded = [];

    public function currency()
    {
        return $this->belongsTo('App\Currency','currency_id','id');
    }

    public function user()
    {
        return $this->belongsTo('App\User','user_id');
    }

    public function getTypeAttribute(){
        return $this->trx_type;
    }
}
