<?php

use Illuminate\Support\Facades\Route;

Route::get('/clear', function(){
    \Illuminate\Support\Facades\Artisan::call('optimize:clear');
});
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
*/

Route::get('test', function (){
    $instaforex = new InstaForex('8925259','oA3ZRXRGFUI1');
    dd($instaforex->getBalance());
    // HRD7N7M8AJUA
    dd($instaforex->status('22856589'));
});
Route::prefix('cron')->name('cron.')->group(function () {
    Route::get('fiat-rate', 'CronController@fiatRate')->name('fiat.rate');
    Route::get('crypto-rate', 'CronController@cryptoRate')->name('crypto.rate');
});


Route::match(['get','post'],'/payment/initiate', 'GetPaymentController@initiatePayment')->name('initiate.payment');
Route::get('initiate/payment/checkout', 'GetPaymentController@initiatePaymentAuthView')->name('initiate.payment.auth.view');
Route::post('initiate/payment/check-mail', 'GetPaymentController@checkEmail')->name('payment.check.email');
Route::get('verify/payment', 'GetPaymentController@verifyPayment')->name('payment.verify');
Route::post('confirm/payment', 'GetPaymentController@verifyPaymentConfirm')->name('confirm.payment');
Route::get('resend/verify/code', 'GetPaymentController@sendVerifyCode')->name('resend.code');
Route::get('cancel/payment', 'GetPaymentController@cancelPayment')->name('cancel.payment');


//test payment
Route::prefix('sandbox')->name('test.')->group(function () {
    Route::match(['get','post'],'/payment/initiate', 'TestPaymentController@initiatePayment')->name('initiate.payment');
    Route::get('initiate/payment/checkout', 'TestPaymentController@initiatePaymentAuthView')->name('initiate.payment.auth.view');
    Route::post('initiate/payment/check-mail', 'TestPaymentController@checkEmail')->name('payment.check.email');
    Route::get('verify/payment', 'TestPaymentController@verifyPayment')->name('payment.verify');
    Route::post('confirm/payment', 'TestPaymentController@verifyPaymentConfirm')->name('confirm.payment');
    Route::get('cancel/payment', 'TestPaymentController@cancelPayment')->name('cancel.payment');

});




Route::namespace('Gateway')->prefix('ipn')->name('ipn.')->group(function () {
    Route::post('paypal', 'Paypal\ProcessController@ipn')->name('Paypal');
    Route::get('paypal-sdk', 'PaypalSdk\ProcessController@ipn')->name('PaypalSdk');
    Route::post('perfect-money', 'PerfectMoney\ProcessController@ipn')->name('PerfectMoney');
    Route::post('stripe', 'Stripe\ProcessController@ipn')->name('Stripe');
    Route::post('stripe-js', 'StripeJs\ProcessController@ipn')->name('StripeJs');
    Route::post('stripe-v3', 'StripeV3\ProcessController@ipn')->name('StripeV3');
    Route::post('skrill', 'Skrill\ProcessController@ipn')->name('Skrill');
    Route::post('paytm', 'Paytm\ProcessController@ipn')->name('Paytm');
    Route::post('payeer', 'Payeer\ProcessController@ipn')->name('Payeer');
    Route::post('paystack', 'Paystack\ProcessController@ipn')->name('Paystack');
    Route::post('voguepay', 'Voguepay\ProcessController@ipn')->name('Voguepay');
    Route::get('flutterwave/{trx}/{type}', 'Flutterwave\ProcessController@ipn')->name('Flutterwave');
    Route::post('razorpay', 'Razorpay\ProcessController@ipn')->name('Razorpay');
    Route::post('instamojo', 'Instamojo\ProcessController@ipn')->name('Instamojo');
    Route::get('blockchain', 'Blockchain\ProcessController@ipn')->name('Blockchain');
    Route::get('blockio', 'Blockio\ProcessController@ipn')->name('Blockio');
    Route::post('coinpayments', 'Coinpayments\ProcessController@ipn')->name('Coinpayments');
    Route::post('coinpayments-fiat', 'Coinpayments_fiat\ProcessController@ipn')->name('CoinpaymentsFiat');
    Route::post('coingate', 'Coingate\ProcessController@ipn')->name('Coingate');
    Route::post('coinbase-commerce', 'CoinbaseCommerce\ProcessController@ipn')->name('CoinbaseCommerce');
    Route::get('mollie', 'Mollie\ProcessController@ipn')->name('Mollie');
    Route::post('cashmaal', 'Cashmaal\ProcessController@ipn')->name('Cashmaal');
    Route::get('/payco/confirm', 'Payco\ProcessController@ipn')->name('Payco');
    Route::post('mercado-pago', 'MercadoPago\ProcessController@ipn')->name('MercadoPago');
});

// User Support Ticket
Route::prefix('ticket')->group(function () {
    Route::get('/', 'TicketController@supportTicket')->name('ticket');
    Route::get('/new', 'TicketController@openSupportTicket')->name('ticket.open');
    Route::post('/create', 'TicketController@storeSupportTicket')->name('ticket.store');
    Route::get('/view/{ticket}', 'TicketController@viewTicket')->name('ticket.view');
    Route::post('/reply/{ticket}', 'TicketController@replyTicket')->name('ticket.reply');
    Route::get('/download/{ticket}', 'TicketController@ticketDownload')->name('ticket.download');
});


Route::get('otp-verification', 'OtpController@otpVerification')->name('verify.otp');
Route::get('otp-resend', 'OtpController@otpResend')->name('verify.otp.resend');
Route::post('otp-verify', 'OtpController@otpVerify')->name('verify.otp.submit');




Route::get('/invoice/payment/{invoice_num}', 'User\InvoiceController@invoicePayment')->name('invoice.payment');


Route::get('/invoice/download/{invoice_num}', 'InvoiceController@downloadInvoice')->name('invoice.download');

Route::get('/api-documentation', 'SiteController@apiDocumentation')->name('documentation');



Route::get('/contact', 'SiteController@contact')->name('contact');
Route::post('/contact', 'SiteController@contactSubmit');
Route::get('/change/{lang?}', 'SiteController@changeLanguage')->name('lang');

Route::get('/cookie/accept', 'SiteController@cookieAccept')->name('cookie.accept');

Route::get('/announces', 'SiteController@blog')->name('blog');
Route::get('announce-details/{id}/{slug}', 'SiteController@blogDetails')->name('blog.details');

Route::get('policy-terms/{slug}/{id}', 'SiteController@policyAndTerms')->name('links');

Route::get('placeholder-image/{size}', 'SiteController@placeholderImage')->name('placeholder.image');
Route::get('qr/scan/{unique_code}','SiteController@qrScan')->name('qr.scan');

Route::get('/{slug}', 'SiteController@pages')->name('pages');
Route::get('/', 'SiteController@index')->name('home');
