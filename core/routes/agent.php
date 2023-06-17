<?php

use Illuminate\Support\Facades\Route;



/*
|--------------------------------------------------------------------------
| Start Agent Area
|--------------------------------------------------------------------------
*/


//Deposit
Route::middleware(['agent','module:add_money'])->group(function () {
    Route::any('/payment', 'Gateway\PaymentController@deposit')->name('deposit');
    Route::post('payment/insert', 'Gateway\PaymentController@depositInsert')->name('deposit.insert');
    Route::get('payment/preview', 'Gateway\PaymentController@depositPreview')->name('deposit.preview');
    Route::get('payment/confirm', 'Gateway\PaymentController@depositConfirm')->name('deposit.confirm');
    Route::get('payment/manual', 'Gateway\PaymentController@manualDepositConfirm')->name('deposit.manual.confirm');
    Route::post('payment/manual', 'Gateway\PaymentController@manualDepositUpdate')->name('deposit.manual.update');
});

Route::namespace('Agent')->group(function () {
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

    Route::middleware('agent')->group(function () {
        Route::get('authorization', 'AuthorizationController@authorizeForm')->name('authorization');
        Route::get('resend-verify', 'AuthorizationController@sendVerifyCode')->name('send.verify.code');
        Route::post('verify-email', 'AuthorizationController@emailVerification')->name('verify.email');
        Route::post('verify-sms', 'AuthorizationController@smsVerification')->name('verify.sms');
        Route::post('verify-g2fa', 'AuthorizationController@g2faVerification')->name('go2fa.verify');

        Route::middleware(['checkAgentStatus'])->group(function () {
            Route::get('dashboard', 'AgentController@home')->name('home');
            Route::get('check/insight', 'AgentController@checkInsight')->name('check.insight');
                
            Route::get('profile-setting', 'AgentController@profile')->name('profile.setting');
            Route::post('profile-setting', 'AgentController@submitProfile');
            Route::get('change-password', 'AgentController@changePassword')->name('change.password');
            Route::post('change-password', 'AgentController@submitPassword');
            
            //2FA
            Route::get('twofactor', 'AgentController@show2faForm')->name('twofactor');
            Route::post('twofactor/enable', 'AgentController@create2fa')->name('twofactor.enable');
            Route::post('twofactor/disable', 'AgentController@disable2fa')->name('twofactor.disable');

            

            //Money In
            Route::post('/user/check', 'MoneyInController@checkUser')->name('user.check.exist');
            Route::get('/money-in', 'MoneyInController@moneyInForm')->name('money.in');
            Route::post('/money-in', 'MoneyInController@confirmMoneyIn')->middleware('kyc');
            Route::get('/money-in-done', 'MoneyInController@moneyInDone')->name('money.in.done');

            
            //more wallets
            Route::get('/all/wallets', 'AgentController@allWallets')->name('all.wallets');
              
            // Withdraw
            Route::middleware('module:withdraw_money')->group(function(){
                Route::get('/withdraw/money', 'AgentWithdrawController@withdrawMoney')->name('withdraw.money');
                Route::get('/withdraw/methods', 'AgentWithdrawController@withdrawMethods')->name('withdraw.methods');
                Route::get('/add/withdraw-method', 'AgentWithdrawController@addWithdrawMethod')->name('add.withdraw.method');
                Route::post('/add/withdraw-method', 'AgentWithdrawController@withdrawMethodStore');
                Route::get('/edit/withdraw-method/{id}', 'AgentWithdrawController@withdrawMethodEdit')->name('withdraw.edit');
                Route::post('/withdraw-method/update', 'AgentWithdrawController@withdrawMethodUpdate')->name('withdraw.update');
                Route::post('/withdraw/store', 'AgentWithdrawController@withdrawStore')->name('withdraw.store')->middleware('kyc');
                Route::get('/withdraw/preview', 'AgentWithdrawController@withdrawPreview')->name('withdraw.preview');
                Route::post('/withdraw/preview', 'AgentWithdrawController@withdrawSubmit');
                Route::get('/withdraw/done', 'AgentWithdrawController@withdrawSubmitDone')->name('withdraw.submit.done');
                Route::get('/withdraw/history', 'AgentWithdrawController@withdrawLog')->name('withdraw.history');
            });

            //kyc
            Route::get('/fill-up/kyc', 'AgentController@kycForm')->name('kyc');
            Route::post('/fill-up/kyc', 'AgentController@kycFormSubmit');

            //QR code
            Route::get('/qr-code', 'AgentController@qrCodeGenerate')->name('qr');
            Route::get('/download/qr-code', 'AgentController@downLoadQrJpg')->name('qr.jpg');

            //trx history
            Route::get('/commission-log', 'AgentController@commissionLog')->name('commission.log');
            Route::get('/transaction/history', 'AgentController@trxHistory')->name('transactions');
            Route::get('/add-money/history', 'AgentController@depositHistory')->name('deposit.history')->middleware('module:withdraw_money');

        });
    });
});