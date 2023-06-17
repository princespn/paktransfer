<?php

namespace App\Lib;

use App\Models\AdminNotification;
use App\Models\KycForm;

class Kyc
{

	protected function kycForm(){
		return KycForm::where('user_type',userGuard()['type'])->where('status',1)->first();
	}

	public function verification(){
		$rules = [];
        $inputField = [];
        $userKyc = $this->kycForm();
        if ($userKyc && $userKyc->form_data != null) {
            foreach ($userKyc->form_data as $key => $cus) {
                $rules[$key] = [$cus->validation];
                if ($cus->type == 'file') {
                    array_push($rules[$key], 'image');
                    array_push($rules[$key], 'mimes:jpeg,jpg,png');
                    array_push($rules[$key], 'max:2048');
                }
                if ($cus->type == 'text') {
                    array_push($rules[$key], 'max:191');
                }
                if ($cus->type == 'textarea') {
                    array_push($rules[$key], 'max:300');
                }
                $inputField[] = $key;
            }
        }
        return $rules;
	}

	public function submit($request){
		$path = imagePath()['kyc']['user']['path'];
        $submittedData = $request->except('_token');
        $reqField = [];
        $userKyc = $this->kycForm();
        if ($userKyc && $userKyc->form_data != null) {
            foreach ($userKyc->form_data as $inKey => $inVal) {
                
                $value = @$request[$inKey];
                if (!$value) {
                    continue;
                }
                
                if ($inVal->type == 'file') {
                    if ($request->hasFile($inKey)) {
                        $reqField[$inKey] = [
                            'field_value' => uploadImage($request[$inKey], $path),
                            'type' => $inVal->type,
                        ];
                    }
                } else {
                    $reqField[$inKey] = $value;
                    $reqField[$inKey] = [
                        'field_value' => $value,
                        'type' => $inVal->type,
                    ];
                }
                
            }
            
        }


        $user = userGuard()['user'];
        $user->kyc_info = $reqField;
        $user->kyc_status = 2;
        $user->save();

        $adminNotification = new AdminNotification();
        $adminNotification->user_type = userGuard()['type'];
        $adminNotification->user_id = $user->id;
        $adminNotification->title = 'KYC info submitted by '.$user->username;
        $adminNotification->click_url = urlPath('admin.kyc.info.user.details',$user->id);
        $adminNotification->save();
	}
}