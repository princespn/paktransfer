<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SupportMessage extends Model
{
    protected $guarded = ['id'];

    public function getTypeAttribute(){
        return $this->support_type;
    }


    public function ticket(){
        return $this->belongsTo(SupportTicket::class, 'supportticket_id', 'id');
    }

    public function attachments()
    {
        return $this->hasMany('App\SupportAttachment','support_message_id','id');
    }
}
