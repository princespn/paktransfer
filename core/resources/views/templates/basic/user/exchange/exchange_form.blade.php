@extends($activeTemplate.'layouts.user_master')
@section('content')
<div class="row justify-content-center gy-4 mt-5">
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
                <div class="col-lg-10">
                    <form action="" method="POST" id="form">
                        @csrf 
                        <style>
                        .exchange_input.select {
                            padding: 0.625rem 0.5rem;
                            width: 100%;
                            border: none;                            
                        }
                        .txtcenter{
                            text-align: center;
                        }
                        .txtcenter input{
                            text-align: center;
                            border: none;
                        }
                        .maxtext{
                            font-size: 14px;
                            background: #f3f5f7;
                            border-radius: 30px;
                            padding: 2px 10px;
                            width: fit-content;
                            margin: auto;
                        }
                        .exchange_formbox{
                            background: #fff;
                            padding: 2rem;
                        }
                        .form_innerbox{border: 2px solid #f3f5f7;
                            border-radius: 15px;
                            padding: 2em;
                        }
                        .formbox-head{
                            font-size: 21px;
                        } 
                        </style>
                        <div class="d-widget__content px-5 exchange_formbox" id="main_box" <?php if(Session::has('front_sess_mess')){?> style="display: none;" <?php } ?>> 
                            <div class="form_innerbox">
                                <div class="row">
                                    <div class="col-lg-3 form-group ">
                                        <input id="percent-fee" value="{{ getAmount($exchangeCharge->percent_charge,2) }}" type="hidden">
                                        <input id="fixed-fee" value="{{ getAmount($exchangeCharge->fixed_charge,2) }}" type="hidden">
                                        <label class="mb-0"><span class="text--danger">*</span></label>
                                        <select class="select exchange_input style--two from_currency" name="from_wallet_id"  required>
                                            <option value="">--@lang('Currency')--</option>
                                            @foreach (auth()->user()->wallets()->where('balance','>',0)->get() as $fromWallet)
                                            <option value="{{$fromWallet->id}}" data-code="{{$fromWallet->currency->currency_code}}" data-rate="{{$fromWallet->currency->rate}}" data-type="{{$fromWallet->currency->currency_type}}">{{$fromWallet->currency->currency_code}}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="col-lg-9 form-group txtcenter">
                                        <label class="mb-0"><b>@lang('From')</b><span class="text--danger">*</span> </label>
                                        <input type="number" class="form--control style--two amount" name="amount" placeholder="0.00" required value="{{old('amount')}}">
                                        <div class="maxtext"></div>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-lg-3 form-group">
                                        <input id="percent-fee" value="{{ getAmount($exchangeCharge->percent_charge,2) }}" type="hidden">
                                        <input id="fixed-fee" value="{{ getAmount($exchangeCharge->fixed_charge,2) }}" type="hidden">
                                        <label class="mb-0"><span class="text--danger">*</span></label>
                                        <select class="select style--two exchange_input to_currency" name="to_wallet_id"  required>
                                            <option value="">--@lang('Currency')--</option>
                                            @foreach (auth()->user()->wallets()->where('user_type','USER')->get() as $toWallet)
                                            <option value="{{$toWallet->id}}" data-code="{{$toWallet->currency->currency_code}}" data-rate="{{$toWallet->currency->rate}}" data-type="{{$toWallet->currency->currency_type}}">{{$toWallet->currency->currency_code}}</option>
                                            @endforeach
                                        </select>
                                    </div>
                                    <div class="col-lg-9 form-group txtcenter">
                                        <label class="mb-0"><b>@lang('To')</b><span class="text--danger">*</span> </label>
                                        <input type="number" class="form--control style--two to_amount" name="to_amount" placeholder="0.00" required value="{{old('amount')}}" readonly="">
                                    </div>
                                </div> 
                                <div class="text-center">
                                    <button type="button" class="btn btn-md btn--base mt-4 exchange"  >@lang('NEXT')</button>
                                </div>
                            </div> 
                        </div> 
                        <!--boxcss-->
                        <!--444-->
                        <style>
                            .list_same span{
                                width:50%;
                            }
                            .list_same span.list_value{
                                text-align:right;
                                color: #000; 
                            }
                            .list_same{
                                display: flex;
                            }
                            .list_same small{
                                display: block;
                                margin-top: -8px;
                                color: #ccc;
                            }
                            .in_icon i{
                                margin: 0;
                                line-height: 20px;
                                font-size: 2rem;
                                color: #464646;
                                display: block;
                            }
                            .exchange_dtl{
                                margin-bottom: 2em;
                            }
                            .btn_box{
                                display: flex;
                                justify-content: space-between;
                            }
                            .in_icon{
                                background: #ddd;
                                width: 50px;
                                height: 50px;
                                display: flex;
                                margin: auto;
                                border-radius: 50%;
                                align-items: center;
                                flex-direction: column;
                                justify-content: center;
                            }
                        </style>
                        <div class="d-widget__content px-5 exchange_formbox" id="confirm_exchange_formbox" style="display: none;"> 
                            <div class="text-center formbox-head">
                                    Confirm Exchange
                                </div>
                            <div class="form_innerbox">
                                <div class="Confirm_box">
                                    <div class="exchange_dtl text-center">
                                    <div class="in_icon"><i class="las la-long-arrow-alt-left"></i><i class="las la-long-arrow-alt-right"></i></div><p id="Exchange_from_To_title"></p>
                                        <h3 id="from_value_show_confirm"></h3>
                                    </div> 
                                    <div class="list_tab">
                                        <div class="list_same"><span class="list_lable">Money arrives</span><span class="list_value">Instantly</span></div><hr>
                                        <div class="list_same"><span class="list_lable">Amount to exchange</span><span class="list_value amount_to_exchange"></span></div>
                                        <div class="list_same"><span class="list_lable">Conversion<small class="Include_fee_text"></small></span><span class="list_value Conversion_confirm"></span></div>
                                        <div class="list_same"><span class="list_lable">Fee</span><span class="list_value total_fee"></span></div>
                                    </div> 
                                </div>
                            </div> 
                            <div class="btn_box">
                                <button type="button" class="btn btn-md btn--base mt-4 exchange_back"  >@lang('Back')</button>
                                <button type="button" class="btn btn-md btn--base mt-4 exchange req_confirm"  >@lang('Confirm')</button>
                            </div>
                        </div> 
                        <!--555-->
                        <style>
                            .flex-rev {
                                display: flex;
                                flex-direction: row-reverse;
                                    margin: auto;
                                    width: fit-content;
                            } 
                            .flex-rev svg.sv27{
                                height: 27px;
                                width: 27px;
                                fill: #fff;
                                vertical-align: middle;
                            }
                            .flex-rev svg{
                                fill: transparent;
                                stroke: gold;
                                stroke-width: 40px;
                                padding-right: 10px;
                                cursor: pointer;
                            }   .flex-rev svg.shine {
                                fill: gold;
                            }
                        </style>
                        <?php if(Session::has('front_sess_mess')){?>
                        <div class="d-widget__content px-5 exchange_formbox"> 
                                <div class="Confirm_box">
                                    <div class="exchange_dtl text-center">
                                    <div class="last_in_icon"><i class="fas fa-check-circle"></i></div>
                                        <h3>Exchange successful</h3>
                                    </div>
                                </div> 

                            <div style="text-align: center;">
                                <a href="{{ url('user/dashboard')}}" class="btn btn-md btn--base mt-4"  >@lang('Go to dashboard')</a>
                                <a href="{{ url('user/exchange/money')}}" class="btn btn-md btn--base mt-4"  >@lang('Exchange more')</a>
                            </div>
                                <div class="text-center star_point">
                                    <div class="ratehead">Ratye your experience</div>
                                    <div class="flex-rev">
                                            <svg class="sv27" id="star5" onclick="setRating(5)" viewBox="0 0 576 512" set="false">
                                                <path d="M259.3 17.8L194 150.2 47.9 171.5c-26.2 3.8-36.7 36.1-17.7 54.6l105.7 103-25 145.5c-4.5 26.3 23.2 46 46.4 33.7L288 439.6l130.7 68.7c23.2 12.2 50.9-7.4 46.4-33.7l-25-145.5 105.7-103c19-18.5 8.5-50.8-17.7-54.6L382 150.2 316.7 17.8c-11.7-23.6-45.6-23.9-57.4 0z"></path>
                                            </svg>
                                            <svg class="sv27 shine" id="star4" onclick="setRating(4)" viewBox="0 0 576 512" set="true">
                                                <path d="M259.3 17.8L194 150.2 47.9 171.5c-26.2 3.8-36.7 36.1-17.7 54.6l105.7 103-25 145.5c-4.5 26.3 23.2 46 46.4 33.7L288 439.6l130.7 68.7c23.2 12.2 50.9-7.4 46.4-33.7l-25-145.5 105.7-103c19-18.5 8.5-50.8-17.7-54.6L382 150.2 316.7 17.8c-11.7-23.6-45.6-23.9-57.4 0z"></path>
                                            </svg>
                                            <svg class="sv27 shine" id="star3" onclick="setRating(3)" viewBox="0 0 576 512" set="true">
                                                <path d="M259.3 17.8L194 150.2 47.9 171.5c-26.2 3.8-36.7 36.1-17.7 54.6l105.7 103-25 145.5c-4.5 26.3 23.2 46 46.4 33.7L288 439.6l130.7 68.7c23.2 12.2 50.9-7.4 46.4-33.7l-25-145.5 105.7-103c19-18.5 8.5-50.8-17.7-54.6L382 150.2 316.7 17.8c-11.7-23.6-45.6-23.9-57.4 0z"></path>
                                            </svg>
                                            <svg class="sv27 shine" id="star2" onclick="setRating(2)" viewBox="0 0 576 512" set="true">
                                                <path d="M259.3 17.8L194 150.2 47.9 171.5c-26.2 3.8-36.7 36.1-17.7 54.6l105.7 103-25 145.5c-4.5 26.3 23.2 46 46.4 33.7L288 439.6l130.7 68.7c23.2 12.2 50.9-7.4 46.4-33.7l-25-145.5 105.7-103c19-18.5 8.5-50.8-17.7-54.6L382 150.2 316.7 17.8c-11.7-23.6-45.6-23.9-57.4 0z"></path>
                                            </svg>
                                            <svg class="sv27 shine" id="star1" onclick="setRating(1)" viewBox="0 0 576 512" set="true">
                                                <path d="M259.3 17.8L194 150.2 47.9 171.5c-26.2 3.8-36.7 36.1-17.7 54.6l105.7 103-25 145.5c-4.5 26.3 23.2 46 46.4 33.7L288 439.6l130.7 68.7c23.2 12.2 50.9-7.4 46.4-33.7l-25-145.5 105.7-103c19-18.5 8.5-50.8-17.7-54.6L382 150.2 316.7 17.8c-11.7-23.6-45.6-23.9-57.4 0z"></path>
                                            </svg>
                                        </div>
                                </div>
                        </div>
                    <?php } ?> 
                    </form>
                </div>
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
                function ToExchangeCal(){
                     var amount = $('.amount').val();                     
                    if(amount === ''){
                        notify('error','Please provide the amount first.');
                        return false
                    }
                    var fromCurrRate = parseFloat($('.from_currency option:selected').data('rate'));
                    var baseCurrAmount = amount;

                    var toCurrType = $('.to_currency option:selected').data('type');
                    var toCurrRate =  parseFloat($('.to_currency option:selected').data('rate'));
                    var fee = exchangeFee();
                    var toCurrAmount = baseCurrAmount*fromCurrRate/toCurrRate;
                    var fee = fee*fromCurrRate/toCurrRate; 
                    if(toCurrType === 1){
                       toCurrAmount = (toCurrAmount-fee).toFixed(2);
                    } else{
                       toCurrAmount = (toCurrAmount-fee).toFixed(8);
                    }
                    return toCurrAmount;
                }
                function maximumExchange(){
                    var fee = parseFloat(exchangeFee());
                    var id = $('.from_currency').val();
                    var code = $('.from_currency').find('option:selected').attr('data-code');
                    var fromCurr = $('.from_currency').val();
                    var maximumAmount = parseFloat(wallets[id]);
                    var amount = $('.amount').val();
                    //alert(amount);
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
                        var to_amount = ToExchangeCal(); 
                        $('.to_amount').val(to_amount);
                    }
                });
                @foreach(auth()->user()->wallets as $wallet)
                    wallets[{!! $wallet->id !!}] = "{!! $wallet->balance !!}";
                    @endforeach
                $('.from_currency').on('change', function(){
                    if($(this).val() !== ''){
                        maximumExchange();
                        var maximumAmount = parseFloat(wallets[$(this).val()]);
                         var code = $(this).find('option:selected').attr('data-code');
                        $('.maxtext').html('MAX AMOUNT-'+code+' '+(maximumAmount));
                    }
                });
                 $('.to_currency').on('change',function () {
                    var fromCurr = $('.from_currency option:selected').val();
                    //alert(fromCurr);
                   
                    var to_amount = ToExchangeCal(); 
                    $('.to_amount').val(to_amount);


                    if ( $('.to_currency option:selected').val() == fromCurr ) {
                        notify('error','Can\'t exchange within same wallet.');
                        $('.exchange').attr('disabled',true);
                    } else{
                        $('.exchange').attr('disabled',false);
                    }

                   });

                $('.exchange').on('click',function () {
                    var amount = $('.amount').val();
                    var to_amount = $('.to_amount').val();
                    if(amount === '' || to_amount===''){
                        notify('error','Please provide the amount first.');
                        return false
                    }
                    var to_rate = parseFloat($('.to_currency').find('option:selected').attr('data-rate'));
                    var type = $('.to_currency').find('option:selected').attr('data-type');
                    //console.log(to_rate);
                    var from_amount =  $('.amount').val();
                    var to_amount = (from_amount*to_rate);
                    if(type == 1){
                        to_amount = to_amount.toFixed(2);
                    }
                    else{
                        to_amount = to_amount.toFixed(8);
                    }
                    $('.to_amount').val(to_amount);

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
                    
                    
                    //alert(baseCurrAmount);
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
                    var toOneCurrAmount = 1*(fromCurrRate/toCurrRate);
                    var fee = fee*fromCurrRate/toCurrRate;
                    if(toCurrType === 1){
                       toCurrAmount = (toCurrAmount-fee).toFixed(2);
                    } else{
                       toCurrAmount = (toCurrAmount-fee).toFixed(8);
                    }
                    if(toCurrType === 1){
                       toOneCurrAmount = toOneCurrAmount.toFixed(2);
                    } else{
                       toOneCurrAmount = toOneCurrAmount.toFixed(8);
                    }
                    // alert(toCurrAmount);
                    var to_rate = parseFloat($('.to_currency').find('option:selected').attr('data-rate'));

                    $('#Exchange_from_To_title').html('Exchange From '+fromCurr+' to '+toCurr);
                    $('#from_value_show_confirm').html(amount+' '+fromCurr);
                    $('.amount_to_exchange').html(baseCurrAmount+' '+fromCurr);
                    $('.Conversion_confirm').html(toOneCurrAmount+' '+toCurr+' = 1 '+fromCurr);
                    $('.Include_fee_text').html('Include '+exchangeFee()+' fee');
                    $('.total_fee').html(exchangeFee()+' '+fromCurr);

                    $('.exchange-fee').html(exchangeFee()+' '+toCurr);
                    $('.ammount-exchange').html(baseCurrAmount);
                    $('.currency-exchange').html(fromCurr);
                    $('.exchange-rate').html(totalRate);
                    $('.will-get').html(toCurrAmount);
                    $('#confirm').find('.from_curr').text(fromCurr);
                    $('#confirm').find('.to_curr').text(toCurr);
                    $('#confirm').find('.from_curr_val').text(parseFloat(amount));
                    $('#confirm').find('.to_curr_val').text(parseFloat($('.to_amount').val()));
                    $('.exchange_formbox').hide();
                    $('#confirm_exchange_formbox').show();
                });

                $('.exchange_back').on('click',function () {
                    $('#main_box').show();
                    $('#confirm_exchange_formbox').hide();
                });
                $('.req_confirm').on('click',function () {
                    $('#form').submit()
                    $(this).attr('disabled',true)
                })
            })(jQuery);
     </script>
@endpush