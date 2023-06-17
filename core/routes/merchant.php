<?php

use Illuminate\Support\Facades\Route;




/*
|--------------------------------------------------------------------------
| Start Merchant Area
|--------------------------------------------------------------------------
*/


Route::get('/', 'Auth\LoginController@showLoginForm')->name('login');
Route::post('/', 'Auth\LoginController@login');
Route::get('logout', 'Auth\LoginController@logout')->name('logout');

Route::get('register', 'Auth\RegisterController@showRegistrationForm')->name('register');
Route::post('register', 'Auth\RegisterController@register')->middleware('regStatus');
Route::post('check-mail', 'Auth\RegisterController@checkUser')->name('checkUser');

Route::get('password/reset', 'Auth\ForgotPasswordController@showLinkRequestForm')->name('password.request');
Route::post('password/email', 'Auth\ForgotPasswordController@sendResetCodeEmail')->name('password.email');
Route::get('password/code-verify', 'Auth\ForgotPasswordController@codeVerify')->name('password.code.verify');
Route::post('password/reset', 'Auth\ResetPasswordController@reset')->name('password.update');
Route::get('password/reset/{token}', 'Auth\ResetPasswordController@showResetForm')->name('password.reset');
Route::post('password/verify-code', 'Auth\ForgotPasswordController@verifyCode')->name('password.verify.code');
Route::middleware('merchant')->group(function () {
    Route::get('authorization', 'AuthorizationController@authorizeForm')->name('authorization');
    Route::get('resend-verify', 'AuthorizationController@sendVerifyCode')->name('send.verify.code');
    Route::post('verify-email', 'AuthorizationController@emailVerification')->name('verify.email');
    Route::post('verify-sms', 'AuthorizationController@smsVerification')->name('verify.sms');
    Route::post('verify-g2fa', 'AuthorizationController@g2faVerification')->name('go2fa.verify');

    Route::middleware(['checkMerchantStatus'])->group(function () {
        Route::get('dashboard', 'MerchantController@home')->name('home');
        Route::get('check/insight', 'MerchantController@checkInsight')->name('check.insight');
        Route::get('business/api/key', 'MerchantController@apiKey')->name('api.key');
        Route::post('generate/api/key', 'MerchantController@generateApiKey')->name('generate.key');

        Route::get('profile-setting', 'MerchantController@profile')->name('profile.setting');
        Route::post('profile-setting', 'MerchantController@submitProfile');
        Route::get('change-password', 'MerchantController@changePassword')->name('change.password');
        Route::post('change-password', 'MerchantController@submitPassword');

        //2FA
        Route::get('twofactor', 'MerchantController@show2faForm')->name('twofactor');
        Route::post('twofactor/enable', 'MerchantController@create2fa')->name('twofactor.enable');
        Route::post('twofactor/disable', 'MerchantController@disable2fa')->name('twofactor.disable');

        //all wallets
        Route::get('/all/wallets', 'MerchantController@allWallets')->name('all.wallets');

       // Withdraw
       Route::middleware('module:withdraw_money')->group(function(){
           Route::get('/withdraw/money', 'MerchantWithdrawController@withdrawMoney')->name('withdraw.money');
           Route::get('/withdraw/methods', 'MerchantWithdrawController@withdrawMethods')->name('withdraw.methods');
           Route::get('/add/withdraw-method', 'MerchantWithdrawController@addWithdrawMethod')->name('add.withdraw.method');
           Route::post('/add/withdraw-method', 'MerchantWithdrawController@withdrawMethodStore');
           Route::get('/edit/withdraw-method/{id}', 'MerchantWithdrawController@withdrawMethodEdit')->name('withdraw.edit');
           Route::post('/withdraw-method/update', 'MerchantWithdrawController@withdrawMethodUpdate')->name('withdraw.update');
           Route::post('/withdraw/store', 'MerchantWithdrawController@withdrawStore')->name('withdraw.store')->middleware('kyc');
           Route::get('/withdraw/preview', 'MerchantWithdrawController@withdrawPreview')->name('withdraw.preview');
           Route::post('/withdraw/preview', 'MerchantWithdrawController@withdrawSubmit');
           Route::get('/withdraw/done', 'MerchantWithdrawController@withdrawSubmitDone')->name('withdraw.submit.done');
           Route::get('/withdraw/history', 'MerchantWithdrawController@withdrawLog')->name('withdraw.history');
       });

        //kyc
        Route::get('/fill-up/kyc', 'MerchantController@kycForm')->name('kyc');
        Route::post('/fill-up/kyc', 'MerchantController@kycFormSubmit');

        //QR code
        Route::get('/qr-code', 'MerchantController@qrCodeGenerate')->name('qr');
        Route::get('/download/qr-code', 'MerchantController@downLoadQrJpg')->name('qr.jpg');

       Route::get('/transaction/history', 'MerchantController@trxHistory')->name('transactions');

    });
});