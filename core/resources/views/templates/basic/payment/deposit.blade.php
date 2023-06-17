@extends($activeTemplate.'layouts.'.strtolower(userGuard()['type']).'_master')
@php
    $class = '';
    if (userGuard()['type'] == 'AGENT' || userGuard()['type'] == 'USER' || userGuard()['type'] == 'MERCHANT'){
        $class = 'mt-5';
    }
@endphp
@section('content')
    <form action="{{route(strtolower(userGuard()['type']).'.deposit.insert')}}" method="POST" id="form">
        @csrf
        <div class="row justify-content-center gy-4 {{$class}}">
            <div class="dashboard-inner-content" id="step_one">
                <label class="text-center">@lang('Select Gateway')</label>
                <div class="getway_boxes row">
                    @foreach (userGuard()['user']->wallets as $wallet)
                        @foreach($wallet->gateways() as $gateway)
                            <div class="card mb-3">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-2 justify-content-center align-items-center d-flex">
                                            <img src="{!! $gateway->image ? url('assets/images/gateway/'.$gateway->image) : 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png' !!}" class="card-img w-50" alt="{!! $gateway->name !!}">
                                        </div>
                                        <div class="col-md-7">
                                            <p class="text-center text-lg-start"><strong>{!! $gateway->name !!}</strong></p>
                                        </div>
                                        <div class="col-md-3 d-flex justify-content-center align-items-center">
                                            <a class="btn btn-primary btn-sm" href="javascript:void(0)"
                                               id="getMethodData{!! $gateway->method_code !!}_{{$wallet->id}}"
                                               data-code="{{$wallet->currency->currency_code}}"
                                               data-sym="{{$wallet->currency->currency_symbol}}"
                                               data-currency="{{$wallet->currency->id}}"
                                               data-type="{{$wallet->currency->currency_type}}"
                                               data-rate="{{$wallet->currency->rate}}"
                                               data-max="{!! $gateway->max_amount !!}" data-wallet-id="{!! $wallet->id !!}"
                                               data-min="{{$gateway->min_amount}}"
                                               data-fixcharge = "{{$gateway->fixed_charge}}"
                                               data-percent="{{$gateway->percent_charge}}"
                                               data-value="{{$gateway->method_code}}" data-name="{{$gateway->name}}"
                                               onclick="return setMethad({{$gateway->method_code}}, {{$wallet->id}})">@lang('Deposit Now')</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        @endforeach
                    @endforeach
                </div>
            </div>
            <div class="dashboard-inner-content" id="step_second" style="display: none;">

                <label class="text-center">@lang('Select Gateway')</label>
                <div class="row getway_boxes">
                </div>
            </div>
        </div>
        @php
            $exchangeCharge = \App\Models\TransactionCharge::where('slug','exchange_charge')->first();
        @endphp
        <input type="hidden" class="exchange_percent" value="{!! $exchangeCharge->percent_charge !!}">
        <input type="hidden" class="exchange_fixed" value="{!! $exchangeCharge->fixed_charge !!}">
        <div class="row thrid_second" style="display:none;">
            <div class="col-md-6 mx-auto">
                <div class="add-money-card">
                    <div class="form-group">
                        <label>@lang('Selected Wallet')</label>
                        <select class="form-control user_wallet" name="wallet_id" id="wallet">
                            @foreach(userGuard()['user']->wallets as $wallet)
                                <option data-code="{{$wallet->currency->currency_code}}" data-type="{{$wallet->currency->currency_type}}" data-rate="{!! $wallet->currency->rate !!}" value="{!! $wallet->id !!}">{!! $wallet->currency_code !!}</option>
                            @endforeach

                        </select>
                        <input type="hidden" name="currency" >
                        <input type="hidden" name="rate" >
                        <input type="hidden" name="currency_id" >
                        <input type="hidden" name="method_code" id="method_code">
                    </div>
                    <div class="form-group">
                        <label>@lang('Selected Gateway')</label>
                        <p id="show_method_code"></p>
                    </div>
                    <div class="form-group mb-0">
                        <label>@lang('Amount')</label>
                        <div class="input-group">
                            <input class="form--control amount" type="text" name="amount" disabled placeholder="Enter Amount" value="{{old('amount') }}" required>
                            <span class="input-group-text curr_code"></span>
                        </div>
                        <p><code class="text--warning limit">@lang('limit') : 0.00 <span class="curr_code"></span></code></p>
                    </div>
                    <h4 class="title mt-3"><i class="lar la-file-alt"></i> @lang('Summery')</h4>
                    <div class="add-moeny-card-middle">
                        <ul class="add-money-details-list">
                            <li>
                                <span class="caption">@lang('Amount')</span>
                                <div class="value"><span class="sym">{{$general->cur_sym}}</span><span class="show-amount">0.00</span></div>
                            </li>
                            <li>
                                <span class="caption">@lang('Charge')</span>
                                <div class="value charge_fee"> <span class="sym">{{$general->cur_sym}}</span><span class="charge">0.00</span> </div>
                            </li>
                            <li class="conversion_rate" style="display: none">
                                <span class="caption">@lang('Conversion Rate')</span>
                                <div class="value"></div>
                            </li>
                            <li>
                                <span class="caption">@lang('Payable')</span>
                                <div class="value"> <span class="sym">{{$general->cur_sym}}</span><span class="payable">0.00</span> </div>
                            </li>
                        </ul>
                        <div class="add-money-details-bottom">
                            <span class="caption">@lang('You will get')</span>
                            <div class="value final_amount"><span class="sym">{{$general->cur_sym}}</span><span>0.00</span> </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <button type="button" class="btn btn-md btn-secondary w-100 mt-3 btn-back-gateways">@lang('Back')</button>
                        </div>
                        <div class="col-6">
                            <button type="submit" class="btn btn-md btn--base w-100 mt-3 req_confirm">@lang('Proceed')</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <style>
        .in_header{
            background: #000036;
            color: #ffffff;
            padding: 1em;
        }
        .in_btn a{
            color: #ffffff;}
        .in_btn{
            padding: 1em;
            text-align:center;
            display:block;
            border-top: 1px solid #ddd;
        }
        .in_btn a{
            background: #fd6500;
            color: #ffffff;
            padding: 1em;
            width:100%;
        }
        .getway_in{
            background: #fff;
            display:block;
        }
        .in_image{
            padding:1em;
            /*height: 270px;*/
        }
        .getway_boxes{
            margin:1em auto;
        }

    </style>
@endsection

@push('script')
    <script>
        var  set_wallet_id = '';
        var set_method_code = '';
        function setMethad(method_code,currency_id) {
            $('.amount').removeAttr('disabled');
            $('.thrid_second').slideDown();
            $('#step_second').hide();
            $('#step_one').slideUp();
            set_method_code = method_code;
            var codename = $('#getMethodData'+method_code+'_'+currency_id).data('name');
            var wallet_id = $('#getMethodData'+method_code+'_'+currency_id).data('wallet-id');
            var symbolCur = $('#getMethodData'+method_code+'_'+currency_id).data('sym');
            set_wallet_id = wallet_id;
            $('input[name=currency]').val($('#getMethodData'+method_code+'_'+currency_id).data('code'));
            $('input[name=rate]').val($('#getMethodData'+method_code+'_'+currency_id).data('rate'));
            $('input[name=currency_id]').val($('#getMethodData'+method_code+'_'+currency_id).data('currency'));
            var code = $('#getMethodData'+method_code+'_'+currency_id).data('code');
            $('#show_wallet').text(code);
            $('.sym').html(symbolCur);
            $('select[name="wallet_id"]').val(wallet_id);
            $('#method_code').val(method_code);
            $('#show_method_code').text(codename);
            $('.amount').val('');
            changeDeposit();
        }

        function setWallet(wallet_id) {
            // body...
            //$('#walletDetail'+setWallet).data('');
            var gateways = $('#walletDetail'+wallet_id).data('gateways');
            if(gateways.length > 0){
                $('#wallet').val(wallet_id);
                $('#wallet').attr("disabled", true);
                $('#step_second').show();
                $('#step_one').hide();
                set_wallet_id = wallet_id;
                $('input[name="wallet_id"]').val(wallet_id);
                var html = '';
                $.each(gateways, function (i, val) {
                    html += `
                    <div class="col-md-3">
                        <di class="getway_in">
                            <div class="in_header">${val.name}</div>
                            <div class="in_image">`;
                    if(val.image!=null){
                        html += ` <img src="{{url('assets/images/gateway')}}/${val.image}" class="card-img" alt="${val.name}">`;
                    }else{
                        html += ` <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png" class="card-img" alt="${val.name}">`;
                    }
                    html += `  </div>
                            <div class="in_btn"><a href="javascript:void(0)" id="getMethodData${val.method_code}" data-max="${val.max_amount}" data-min="${val.min_amount}" data-fixcharge = "${val.fixed_charge}" data-percent="${val.percent_charge}"  data-value="${val.method_code}" data-name="${val.name}" onclick="return setMethad(${val.method_code})">WITHDRAW NOW</a></div>
                        </di>
                    </div>`;
                });
                $('input[name=currency]').val($('#walletDetail'+wallet_id).data('code'));
                $('input[name=currency_id]').val($('#walletDetail'+wallet_id).data('currency'))
                $('#wallet_id').val(wallet_id);
                var code = $('#walletDetail'+wallet_id).data('code');
                $('#show_wallet').text(code);
                $('#step_second .getway_boxes').append(html);
            } else{
                $('.gateway').attr('disabled',true)
                $('.gateway').append(html)
                notify('error','No gateway found with this currency.');
                return false;
            }
            return false;
        }
        function formatToCurrency(amount,precesion){
            return (amount).toFixed(precesion).replace(/\d(?=(\d{3})+\.)/g, '$&,');
        }
        function changeDeposit(){
            var amount = parseFloat($('.amount').val()) ;
            var type =  parseFloat($('#getMethodData'+set_method_code+'_'+set_wallet_id).data('type'));
            var code =  $('#getMethodData'+set_method_code+'_'+set_wallet_id).data('code');
            var rate =  parseFloat($('#getMethodData'+set_method_code+'_'+set_wallet_id).data('rate'));
            var selected_wallet_type = parseFloat($('.user_wallet option:selected').attr('data-type'));
            var selected_wallet_code = $('.user_wallet option:selected').attr('data-code');
            var selected_wallet_rate = parseFloat($('.user_wallet option:selected').attr('data-rate'));
            var fixed = parseFloat( $('#getMethodData'+set_method_code+'_'+set_wallet_id).data('fixcharge'));
            var percent = (amount * parseFloat( $('#getMethodData'+set_method_code+'_'+set_wallet_id).data('percent')))/100;
            var rateAmount = rate/selected_wallet_rate;
            var exchange_percent = parseFloat($('.exchange_percent').val());
            var exchange_fixed = parseFloat($('.exchange_fixed').val());
            var exchangeFee = 0;
            if(code !== selected_wallet_code) {
                if (exchange_percent > 0) {
                    exchangeFee += amount * exchange_percent / 100;
                }
                if (exchange_fixed > 0) {
                    exchangeFee += exchange_fixed / rate;
                }
            }
            var totalCharge = fixed + percent + exchangeFee;
            var totalAmount = amount;
            var fAmount = amount-totalCharge;
            var convertedAmount = amount-totalCharge;
            var precesion = 0;
            var precesion_convert = 2;
            $('input[name=rate]').val(rateAmount);
            if(type === 1 ){
                precesion = 2;
            } else {
                precesion = 8;
            }
            var defaultAmount = 0 ;
            if(selected_wallet_type === 1 ){
                precesion_convert = 2;
            } else {
                precesion_convert = 8;
            }
            if(selected_wallet_code !== code){
                convertedAmount = convertedAmount*rateAmount;
                if(type === selected_wallet_type){
                    if(selected_wallet_code === 'USD'){
                        $('.conversion_rate').show().find('.value').html('1'+selected_wallet_code+' = '+formatToCurrency(selected_wallet_rate/rate, precesion)+code);
                    }
                    else{
                        $('.conversion_rate').show().find('.value').html('1'+code+' = '+formatToCurrency(rateAmount,precesion_convert)+selected_wallet_code);
                    }
                }
                else if(type === 1 && selected_wallet_type === 2){
                    $('.conversion_rate').show().find('.value').html('1'+selected_wallet_code+' = '+formatToCurrency(selected_wallet_rate/rate, precesion)+code);
                }
                else{
                    $('.conversion_rate').show().find('.value').html('1'+code+' = '+formatToCurrency(rateAmount,precesion_convert)+selected_wallet_code);
                }
            }
            else{
                $('.conversion_rate').hide();
            }
            if(!isNaN(amount)){
                $('.show-amount').text(formatToCurrency(fAmount,precesion));
                $('.charge').text(formatToCurrency(totalCharge,precesion));
                $('.payable').text(formatToCurrency(totalAmount,precesion));
                $('.final_amount').html('<span class="sym">'+selected_wallet_code+'</span><span>'+formatToCurrency(convertedAmount,precesion_convert)+'</span>');
            }
            else{
                $('.show-amount').text(defaultAmount.toFixed(precesion));
                $('.charge').text(defaultAmount.toFixed(precesion));
                $('.payable').text(defaultAmount.toFixed(precesion));
                $('.final_amount').html('<span class="sym">'+selected_wallet_code+'</span><span>'+defaultAmount.toFixed(precesion_convert)+'</span>');
            }
        }
        'use strict';
        (function ($) {
            $('.btn-back-gateways').click(function(){
                $('.thrid_second').slideUp();
                $('#step_one').slideDown();
            });
            $('.user_wallet').on('change',function () {
                if($('#wallet option:selected').val() == ''){
                    return false
                }
                changeDeposit();
            })

            $('.gateway').on('change',function () {
                console.log('ok');
                if($('.gateway option:selected').val() == ''){
                    $('.amount').attr('disabled',true)
                    $('.charge').text('0.00')
                    $('.payable').text(parseFloat($('.amount').val()))
                    $('.limit').text('limit : 0.00 USD')
                    return false
                }
                $('.amount').removeAttr('disabled')
                var amount = $('.amount').val() ? parseFloat( $('.amount').val()):0;
                var code = $('#wallet option:selected').data('code')

                var type = $('#wallet option:selected').data('type')
                var min = parseFloat($('.gateway option:selected').data('min'))
                var max = parseFloat( $('.gateway option:selected').data('max'))
                var fixed = parseFloat($('.gateway option:selected').data('fixcharge'))
                var pCharge = parseFloat($('.gateway option:selected').data('percent'))
                var percent = (amount * parseFloat($('.gateway option:selected').data('percent')))/100

                var totalCharge = fixed + percent
                var totalAmount = amount+totalCharge
                var precesion = 0;

                if(type == 1 ){
                    precesion = 2;
                } else {
                    precesion = 8;
                }
                console.log('ok');
                $('.charge').text(totalCharge.toFixed(precesion))
                $('.payable').text(totalAmount.toFixed(precesion))
                $('.limit').text('limit : ' +min.toFixed(precesion) +' ~ '+ max.toFixed(precesion)+' '+code)

                $('.f_charge').text(fixed)
                $('.p_charge').text(pCharge)

            })

            $('.amount').on('keyup',function () {
                changeDeposit();
            })

            $('.req_confirm').on('click',function () {
                if($('.amount').val() == '' || $('.gateway option:selected').val() == ''|| $('#wallet option:selected').val() == ''){
                    notify('error','All fields are required')
                    return false
                }
                $('#form').submit()
                $(this).attr('disabled',true)
            })
        })(jQuery);
    </script>
@endpush
