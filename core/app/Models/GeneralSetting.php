<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class GeneralSetting extends Model
{
    protected $guarded = ['id'];

    protected $casts = ['mail_config' => 'object','sms_config' => 'object','cron_run'=>'object'];

    public function currency()
    {
        return $this->belongsTo(Currency::class,'cur_text','currency_code');
    }

    public function scopeSitename($query, $pageTitle)
    {
        $pageTitle = empty($pageTitle) ? '' : ' - ' . $pageTitle;
        return $this->sitename . $pageTitle;
    }
}
