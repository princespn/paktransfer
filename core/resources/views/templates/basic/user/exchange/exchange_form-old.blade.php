@extends($activeTemplate.'layouts.user_master')
@section('content')

<div class="col-xl-10">
    <div class="card style--two">
        <div class="card-header d-flex flex-wrap align-items-center justify-content-center">
            <div class="bank-icon  me-2">
                <i class="las la-wallet"></i>
            </div>
            <h4 class="fw-normal">@lang($pageTitle)</h4>
        </div>
        <div class="card-body p-4">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <form action="" method="POST" id="form">
                        @csrf
                        <div class="d-widget">
                            <div class="d-widget__header">
                                <h6>@lang('Exchange')</h4>
                            </div>
                            <div class="d-widget__content px-5">
                                <div class="p-4 border mb-4">
                                    <div class="row">
                                        <div class="col-lg-12 form-group">
                                            <label class="mb-0">@lang('Amount')<span class="text--danger">*</span> </label>
                                            <input type="number" class="form--control style--two amount" name="amount" placeholder="0.00" required value="{{old('amount')}}">
                                        </div>
                                    </div><!-- row end -->
                                </div>

                                <div class="p-4 border mb-4">
                                    <div class="row">
                                        <div class="col-lg-6 form-group">
                                        <input id="percent-fee" value="{{ getAmount($exchangeCharge->percent_charge,2) }}" type="hidden">
                                        <input id="fixed-fee" value="{{ getAmount($exchangeCharge->fixed_charge,2) }}" type="hidden">
                                            <label class="mb-0">@lang('From Currency')<span class="text--danger">*</span></label>
                                            <select class="select style--two from_currency" name="from_wallet_id"  required>
                                                <option value="">--@lang('From Currency')--</option>
                                                @foreach (auth()->user()->wallets()->where('balance','>',0)->get() as $fromWallet)
                                                <option value="{{$fromWallet->id}}" data-code="{{$fromWallet->currency->currency_code}}" data-rate="{{$fromWallet->currency->rate}}" data-type="{{$fromWallet->currency->currency_type}}">{{$fromWallet->currency->currency_code}}</option>
                                                @endforeach
                                            </select>
                                        </div>
                                        <div class="col-lg-6 form-group">
                                            <label class="mb-0">@lang('To Currency')<span class="text--danger">*</span></label>
                                            <select class="select style--two to_currency" name="to_wallet_id"  required>
                                                <option value="">--@lang('To Currency')--</option>
                                                @foreach (auth()->user()->wallets()->where('user_type','USER')->get() as $toWallet)
                                                <option value="{{$toWallet->id}}" data-code="{{$toWallet->currency->currency_code}}" data-rate="{{$toWallet->currency->rate}}" data-type="{{$toWallet->currency->currency_type}}">{{$toWallet->currency->currency_code}}</option>
                                                @endforeach
                                            </select>
                                        </div>

                                    </div><!-- row end -->
                                </div>

                            </div>
                        </div>
                        <div class="text-center">
                            <button type="button" class="btn btn-md btn--base mt-4 exchange"  >@lang('Exchange')</button>
                        </div>

                        <div class="modal fade" id="confirm" tabindex="-1" role="dialog" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered " role="document">
                            <div class="modal-content">
                                  <div class="modal-header">
                                    <h6 class="modal-title">@lang('Exchange Calculation')</h6>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                  </div>
                                    <div class="modal-body text-center p-0">
                                        <div class="d-widget border-start-0 shadow-sm">
                                            <div class="d-widget__content">
                                                <ul class="cmn-list-two text-center mt-4">
                                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                                        <strong class="from_curr"> </strong>
                                                        <strong class="text--base">@lang('TO')</strong>
                                                        <strong class="to_curr"></strong>
                                                    </li>
                                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                                        <span class="from_curr_val"></span>
                                                        <strong>---------------------------------------------------</strong>
                                                        <span class="to_curr_val"></span>
                                                    </li>
                                                </ul>
                                                <p class="text-start"><span class="fw-bold">@lang('Exchange') <span class="currency-exchange"></span>:</span><span class="ammount-exchange"></span></p>
                                                <p class="text-start"><span class="fw-bold">@lang('Fees'):</span> <span class="exchange-fee"></span></p>
                                                <p class="text-start"><span class="fw-bold">@lang('Rate'):</span> <span class="exchange-rate"></span></p>
                                                <p class="text-start"><span class="fw-bold">@lang('You will get'):</span> <span class="will-get"></span><span class="exchange-to"></span></p>
                                            </div>
                                            <div class="d-widget__footer text-center border-0 pb-3">
                                                <button type="submit" class="btn btn-md w-100 d-block btn--base req_confirm">@lang('Confirm') <i class="las la-long-arrow-alt-right"></i></button>
                                            </div>
                                        </div>
                                    </div>

                               </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@push('script')
     <script>
            'use strict';
            (function ($) {
                var wallets = [];
                function exchangeFee() {
                    var fee = 0;
                    var percentFee = parseFloat($('#percent-fee').val());
                    var fixedFee = parseFloat($('#fixed-fee').val());
                    var amount = parseFloat($('.amount').val());
                    var rate = parseFloat($('.from_currency').find('option:selected').attr('data-rate'));
                    var type = $('.from_currency').find('option:selected').attr('data-type');
                    if(percentFee != '' && percentFee > 0){
                        fee += amount*percentFee/100;
                    }
                    if(fixedFee != '' && fixedFee > 0){
                        fee += fixedFee/rate;
                    }
                    if(type == 1){
                        fee = fee.toFixed(2);
                    }
                    else{
                        fee = fee.toFixed(8);
                    }
                    return fee;
                }
                function maximumExchange(){
                    var fee = parseFloat(exchangeFee());
                    var id = $('.from_currency').val();
                    var code = $('.from_currency').find('option:selected').attr('data-code');
                    var fromCurr = $('.from_currency').val();
                    var maximumAmount = parseFloat(wallets[id]);
                    var amount = $('.amount').val();
                    if(amount !== '' && fromCurr != ''){
                        amount = parseFloat(amount);
                        $('.amount').val(maximumAmount);
                        var maxfee = parseFloat(exchangeFee());
                        
                        $('.amount').val(amount);
                        
                        if((fee > 0 && fee >= maxfee) || (fee == 0 && amount > maximumAmount)){
                            fee = maxfee;
                            alert('You available balance is '+(maximumAmount-fee)+' '+code+' for exchange');
                            $('.amount').val(maximumAmount).focus();
                        }
                        $('.exchange').removeAttr('disabled');
                    }
                }
                $('.amount').on('keyup', function () {
                    var amount = $(this).val();
                    if(amount !== ''){
                        maximumExchange();
                    }
                });
                @foreach(auth()->user()->wallets as $wallet)
                    wallets[{!! $wallet->id !!}] = "{!! $wallet->balance !!}";
                    @endforeach
                $('.from_currency').on('change', function(){
                    if($(this).val() !== ''){
                        maximumExchange();
                    }
                });
                 $('.to_currency').on('change',function () {
                    var fromCurr = $('.from_currency option:selected').val();
                    if ( $('.to_currency option:selected').val() == fromCurr ) {
                        notify('error','Can\'t exchange within same wallet.');
                        $('.exchange').attr('disabled',true);
                    } else{
                        $('.exchange').attr('disabled',false);
                    }

                   });

                $('.exchange').on('click',function () {
                    var amount = $('.amount').val();
                    if(amount === ''){
                        notify('error','Please provide the amount first.');
                        return false
                    }
                    var fromCurr = $('.from_currency option:selected').data('code');
                    var toCurr = $('.to_currency option:selected').data('code');
                    if(!fromCurr || !toCurr){
                        notify('error','Please select the currencies.');
                        return false
                    }
                    var toCurrType = $('.to_currency option:selected').data('type');
                    var fromCurrType = $('.from_currency option:selected').data('type');
                    var fromCurrRate = parseFloat($('.from_currency option:selected').data('rate'));
                    var baseCurrAmount = amount;
                    var toCurrRate =  parseFloat($('.to_currency option:selected').data('rate'));
                    var fee = exchangeFee();


                    var siteCurRate = 1 / fromCurrRate;
                    var myCurRate = siteCurRate * toCurrRate;

                    var totalRate = fromCurrRate/toCurrRate;
                    if(fromCurrType == 2){
                        totalRate = totalRate.toFixed(8);
                    }
                    else if(toCurrType == 1){
                        totalRate = totalRate.toFixed(2);
                    }
                    else{
                        totalRate = totalRate.toFixed(8);
                    }
                    var toCurrAmount = baseCurrAmount*fromCurrRate/toCurrRate;
                    var fee = fee*fromCurrRate/toCurrRate;
                    if(toCurrType === 1){
                       toCurrAmount = (toCurrAmount-fee).toFixed(2);
                    } else{
                       toCurrAmount = (toCurrAmount-fee).toFixed(8);
                    }
                    
                    $('.exchange-fee').html(exchangeFee()+' '+fromCurr);
                    $('.ammount-exchange').html(baseCurrAmount);
                    $('.currency-exchange').html(fromCurr);
                    $('.exchange-rate').html(totalRate);
                    $('.will-get').html(toCurrAmount);
                    $('#confirm').find('.from_curr').text(fromCurr);
                    $('#confirm').find('.to_curr').text(toCurr);
                    $('#confirm').find('.from_curr_val').text(parseFloat(amount));
                    $('#confirm').find('.to_curr_val').text(toCurrAmount);
                    $('#confirm').modal('show')
                });

                $('.req_confirm').on('click',function () {
                    $('#form').submit()
                    $(this).attr('disabled',true)
                })
            })(jQuery);
     </script>
@endpush