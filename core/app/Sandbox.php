<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Sandbox extends Model
{
    protected $guarded = ['id'];

    protected $table = "sandboxes";
    public function currency()
    {
        return $this->belongsTo('App\Currency','currency_id','id');
    }

}
