<?php

use Illuminate\Support\Facades\Route;





/*
|--------------------------------------------------------------------------
| Start User Area
|--------------------------------------------------------------------------
*/


Route::namespace('User')->name('user.')->group(function () {
    Route::get('/login', 'Auth\LoginController@showLoginForm')->name('login');
    Route::post('/login', 'Auth\LoginController@login');
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
});

Route::name('user.')->prefix('user')->group(function () {
    Route::middleware('auth')->group(function () {
        Route::get('authorization', 'User\AuthorizationController@authorizeForm')->name('authorization');
        Route::get('resend-verify', 'User\AuthorizationController@sendVerifyCode')->name('send.verify.code');
        Route::post('verify-email', 'User\AuthorizationController@emailVerification')->name('verify.email');
        Route::post('verify-sms', 'User\AuthorizationController@smsVerification')->name('verify.sms');
        Route::post('verify-g2fa', 'User\AuthorizationController@g2faVerification')->name('go2fa.verify');

        Route::middleware(['checkStatus'])->group(function () {

            // Deposit
            Route::middleware('module:add_money')->group(function(){
                Route::any('/payment', 'Gateway\PaymentController@deposit')->name('deposit');
                Route::post('payment/insert', 'Gateway\PaymentController@depositInsert')->name('deposit.insert');
                Route::get('payment/preview', 'Gateway\PaymentController@depositPreview')->name('deposit.preview');
                Route::get('payment/confirm', 'Gateway\PaymentController@depositConfirm')->name('deposit.confirm');
                Route::get('payment/manual', 'Gateway\PaymentController@manualDepositConfirm')->name('deposit.manual.confirm');
                Route::post('payment/manual', 'Gateway\PaymentController@manualDepositUpdate')->name('deposit.manual.update');
            });

            Route::namespace('User')->group(function(){
                Route::get('dashboard', 'UserController@home')->name('home');
                Route::get('check/insight', 'UserController@checkInsight')->name('check.insight');

                Route::get('profile-setting', 'UserController@profile')->name('profile.setting');
                Route::post('profile-setting', 'UserController@submitProfile');
                Route::get('change-password', 'UserController@changePassword')->name('change.password');
                Route::post('change-password', 'UserController@submitPassword');

                //2FA
                Route::get('twofactor', 'UserController@show2faForm')->name('twofactor');
                Route::post('twofactor/enable', 'UserController@create2fa')->name('twofactor.enable');
                Route::post('twofactor/disable', 'UserController@disable2fa')->name('twofactor.disable');
                Route::get('payment/history', 'UserController@depositHistory')->name('deposit.history')->middleware('module:add_money');

                Route::get('/invoice/payment/confirm/{invoice_num}', 'InvoiceController@invoicePaymentConfirm')->name('invoice.payment.confirm')->middleware('kyc');


                // Withdraw
                Route::middleware('module:withdraw_money')->group(function(){
                    Route::get('/withdraw', 'UserWithdrawController@withdrawMoney')->name('withdraw.money');
                    Route::get('/withdraw/methods', 'UserWithdrawController@withdrawMethods')->name('withdraw.methods');
                    Route::get('/add/withdraw-method', 'UserWithdrawController@addWithdrawMethod')->name('add.withdraw.method');
                    Route::post('/add/withdraw-method', 'UserWithdrawController@withdrawMethodStore');
                    Route::get('/edit/withdraw-method/{id}', 'UserWithdrawController@withdrawMethodEdit')->name('withdraw.edit');
                    Route::post('/withdraw-method/update', 'UserWithdrawController@withdrawMethodUpdate')->name('withdraw.update');
                    Route::post('/withdraw/store', 'UserWithdrawController@withdrawStore')->name('withdraw.store')->middleware('kyc');
                    Route::get('/withdraw/preview', 'UserWithdrawController@withdrawPreview')->name('withdraw.preview');
                    Route::post('/withdraw/preview', 'UserWithdrawController@withdrawSubmit');
                    Route::post('/withdraw/add_method', 'UserWithdrawController@withdrawAddMethod')->name('withdraw.addmethod');
                    Route::post('/withdraw/save_method', 'UserWithdrawController@withdrawSaveMethod')->name('withdraw.savemethod');
                    Route::post('/withdraw/delete_method', 'UserWithdrawController@withdrawDeleteMethod')->name('withdraw.deletemethod');
                    Route::get('/withdraw/done', 'UserWithdrawController@withdrawSubmitDone')->name('withdraw.submit.done');
                    Route::get('/withdraw/history', 'UserWithdrawController@withdrawLog')->name('withdraw.history');
                });

                //Transfer money
                Route::middleware('module:transfer_money')->group(function(){
                    Route::get('/transfer/money', 'UserOperationController@transfer')->name('transfer');
                    Route::post('/transfer/money', 'UserOperationController@transferMoney')->middleware('kyc');
                    Route::get('/transfer/money-done', 'UserOperationController@transferMoneyDone')->name('transfer.done')->middleware('kyc');
                    Route::post('/user/exist', 'UserOperationController@checkUser')->name('check.exist');
                });

                //more wallets
                Route::get('/all/wallets', 'UserController@allWallets')->name('all.wallets');

                //Request money
                Route::middleware('module:request_money')->group(function(){
                    Route::get('/requests', 'UserOperationController@requests')->name('requests');
                    Route::get('/request/money', 'UserOperationController@requestMoney')->name('request.money');
                    Route::post('/request/money', 'UserOperationController@confirmRequest')->middleware('kyc');
                    Route::post('/accept/request', 'UserOperationController@requestAccept')->name('request.accept');
                    Route::get('/accept/done', 'UserOperationController@requestAcceptDone')->name('request.accept.done');
                    Route::post('/accept/reject', 'UserOperationController@requestReject')->name('request.reject');
                });


                //Invoice
                Route::middleware('module:create_invoice')->group(function(){
                    Route::get('/invoice/list', 'InvoiceController@invoices')->name('invoices');
                    Route::get('/invoice/create', 'InvoiceController@createInvoice')->name('invoice.create');
                    Route::post('/invoice/create', 'InvoiceController@createInvoiceConfirm');
                    Route::get('/invoice/edit/{invoice_num}', 'InvoiceController@editInvoice')->name('invoice.edit');
                    Route::post('/invoice/update/', 'InvoiceController@updateInvoice')->name('invoice.update');
                    Route::get('/send-to-mail/invoice/{invoice_num}', 'InvoiceController@sendInvoiceToMail')->name('invoice.send.mail');
                    Route::get('/publish/invoice/{invoice_num}', 'InvoiceController@publishInvoice')->name('invoice.publish');
                    Route::post('/discard/invoice/{invoice_num}', 'InvoiceController@discardInvoice')->name('invoice.discard');
                });

                //money out
                Route::middleware('module:money_out')->group(function(){
                    Route::post('/agent/exist', 'MoneyOutController@checkUser')->name('agent.check.exist');
                    Route::get('/money-out', 'MoneyOutController@moneyOut')->name('money.out');
                    Route::post('/money-out', 'MoneyOutController@moneyOutConfirm')->middleware('kyc');
                    Route::get('/money-out-done', 'MoneyOutController@moneyOutDone')->name('money.out.done')->middleware('kyc');
                });

                //make payment
                Route::middleware('module:make_payment')->group(function(){
                    Route::post('/merchant/exist', 'MakePaymentController@checkUser')->name('merchant.check.exist');
                    Route::get('/make-payment', 'MakePaymentController@paymentFrom')->name('payment');
                    Route::post('/make-payment', 'MakePaymentController@paymentConfirm')->middleware('kyc');
                    Route::get('/make-payment-done', 'MakePaymentController@paymentDone')->name('payment.done')->middleware('kyc');
                });

                //Voucher
                Route::middleware('module:create_voucher')->group(function(){
                    Route::get('/voucher/list', 'VoucherController@userVoucherList')->name('voucher.list');
                    Route::get('/create/voucher', 'VoucherController@userVoucher')->name('voucher.create');
                    Route::post('/create/voucher', 'VoucherController@userVoucherCreate')->middleware('kyc');
                    Route::get('/create/voucher-done', 'VoucherController@userVoucherCreateDone')->name('voucher.create.done')->middleware('kyc');
                    Route::get('/voucher/redeem', 'VoucherController@userVoucherRedeem')->name('voucher.redeem');
                    Route::post('/voucher/redeem', 'VoucherController@userVoucherRedeemConfirm');
                    Route::get('/voucher/redeem/log', 'VoucherController@userVoucherRedeemLog')->name('voucher.redeem.log');
                });

                //Exchange money
                Route::middleware('module:money_exchange')->group(function(){
                    Route::get('/exchange/money', 'MoneyExchangeController@exchangeForm')->name('exchange.money');
                    Route::post('/exchange/money', 'MoneyExchangeController@exchangeConfirm');
                });

                //kyc
                Route::get('/fill-up/kyc', 'UserController@kycForm')->name('kyc');
                Route::post('/fill-up/kyc', 'UserController@kycFormSubmit');

                 //QR code
                Route::get('/qr-code', 'UserController@qrCodeGenerate')->name('qr');
                Route::get('/download/qr-code', 'UserController@downLoadQrJpg')->name('qr.jpg');

                //Trx history
                Route::get('/transaction/history', 'UserController@trxHistory')->name('transactions');
            });
        });
    });
});
