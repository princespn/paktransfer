@extends('special.layouts.master')
@php
$content = getContent('login.content',true)->data_values;
$policies = getContent('policies.element',false,'',1);
@endphp
@section('content')
    <div class="page-wrapper default-version">
        <div class="form-area bg_img" data-background="{{asset('assets/admin/images/1.jpg')}}">
            <div class="form-wrapper">
                <h4 class="logo-text mb-15">Register</strong></h4>
                <p>Already have an account? <a href="{{route('user.login')}}">Login</a></p>
                <form class="cmn-form mt-30" action="{{ route('user.register') }}" method="POST"onsubmit="return submitUserForm();">
                    @csrf
                        <div class="row mb-3">
                            <div class="col-6">
                                <div class="user-account-check text-center">
                                <input class="form-check-input" type="radio" value="personal" name="accountRadioCheck" id="personalAccount" checked>
                                <label class="form-check-label" for="personalAccount">
                                    <i class="las la-user"></i>
                                    <span>@lang('Personal Account')</span>
                                </label>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="user-account-check text-center">
                                <input class="form-check-input" type="radio" value="company" name="accountRadioCheck" id="companyAccount">
                                <label class="form-check-label" for="companyAccount">
                                    <i class="las la-briefcase"></i>
                                    <span>@lang('Company Account')</span>
                                </label>
                                </div>
                            </div>
                            
                        </div>

                        <div class="form-group company-name d-none">
                                <label for="company-name">@lang('Legal Name of Company')</label>
                                <input id="company-name" type="text" class="form-control" name="company_name" placeholder="@lang('Legal Name of Company')"  value="{{ old('company_name') }}" disabled>
                            </div>

                        <div class="form-group">
                            <div class="form-group">
                            <label for="firstname" class="firstname">@lang('First Name')</label>
                            <input id="firstname" type="text" class="form-control" name="firstname" placeholder="@lang('First Name')"  value="{{ old('firstname') }}" required>
                        </div>

                        <div class="form-group">
                            <label for="lastname" class="lastname">@lang('Last Name')</label>
                            <input id="lastname" type="text" class="form-control" name="lastname" placeholder="@lang('Last Name')" value="{{ old('lastname') }}" required>
                        </div>

                        <div class="form-group">
                            <label for="country">{{ __('Country') }}</label>
                            <select name="country" id="country" class="form-control">
                                @foreach($countries as $key => $country)
                                <option data-mobile_code="{{ $country->dial_code }}" value="{{ $country->country }}" data-code="{{ $key }}">{{ __($country->country) }}</option>
                                    @endforeach
                            </select>
                        </div>
                            
                        <div class="form-group">
                            <label for="mobile">@lang('Mobile')</label>
                            <div class="input-group">
                                <span class="input-group-text mobile-code">
                                </span>
                                <input type="hidden" name="mobile_code">
                                <input type="hidden" name="country_code"> 
                                <input type="text" name="mobile" id="mobile" value="{{ old('mobile') }}" class="form-control checkUser" placeholder="@lang('Your Phone Number')">
                            </div>
                                <small class="text-danger mobileExist"></small>
                        </div>

                            <div class="form-group">
                                <label for="username">{{ __('Username') }}</label>
                                <input id="username" type="text" class="form-control checkUser" placeholder="@lang('Username')" name="username" value="{{ old('username') }}" required>
                                <small class="text-danger usernameExist"></small>
                            </div>

                            <div class="form-group">
                                <label for="email">@lang('E-Mail Address')</label>
                                <input id="email" type="email" class="form-control checkUser" placeholder="@lang('Email Address')" name="email" value="{{ old('email') }}" required>
                            </div>

                            <div class="form-group hover-input-popup">
                                <label for="password">@lang('Password')</label>
                                <input id="password" type="password" class="form-control" placeholder="@lang('Password')" name="password" required>
                                @if($general->secure_password)
                                    <div class="input-popup">
                                        <p class="error lower">@lang('1 small letter minimum')</p>
                                        <p class="error capital">@lang('1 capital letter minimum')</p>
                                        <p class="error number">@lang('1 number minimum')</p>
                                        <p class="error special">@lang('1 special character minimum')</p>
                                        <p class="error minimum">@lang('6 character password')</p>
                                    </div>
                                @endif
                            </div>

                            <div class="form-group">
                                <label for="password-confirm">@lang('Confirm Password')</label>
                                 <input id="password-confirm" type="password" class="form-control" placeholder="@lang('Confirm Password')" name="password_confirmation" required autocomplete="new-password">
                            </div>

                            
                            @include($activeTemplate.'partials.custom_captcha')
                            <div class="form-group">
                                @php echo loadReCaptcha() @endphp
                            </div>
                            @if ($general->agree)
                            <div class="form-group">
                                <div class="form-check d-flex align-items-center">
                                    <input class="form-check-input" type="checkbox"  name="agree" id="termsAndConditions">
                                    <label class="form-check-label mb-0 ms-2" for="termsAndConditions">
                                        @lang('I read & agree to') 
                                        @foreach ($policies as $policy)
                                          <a href="{{route('links',[slug($policy->data_values->title),$policy->id])}}"> {{$policy->data_values->title}}</a>
                                        @endforeach
                                    </label>
                                </div>
                            </div>
                            @endif
                    <div class="form-group">
                      <button type="submit" class="submit-btn mt-25">@lang('Create Account')</button>
                    </div>
                </form>
            </div>
            </div>
        </div>
        </div>
    </div>
</section>
@endsection
@push('style')
<style>
    .country-code .input-group-prepend .input-group-text{
        background: #fff !important;
    }
    .country-code select{
        border: none;
    }
    .country-code select:focus{
        border: none;
        outline: none;
    }
    .hover-input-popup {
        position: relative;
    }
    .hover-input-popup:hover .input-popup {
        opacity: 1;
        visibility: visible;
    }
    .input-popup {
        position: absolute;
        bottom: 130%;
        left: 50%;
        width: 280px;
        background-color: #1a1a1a;
        color: #fff;
        padding: 20px;
        border-radius: 5px;
        -webkit-border-radius: 5px;
        -moz-border-radius: 5px;
        -ms-border-radius: 5px;
        -o-border-radius: 5px;
        -webkit-transform: translateX(-50%);
        -ms-transform: translateX(-50%);
        transform: translateX(-50%);
        opacity: 0;
        visibility: hidden;
        -webkit-transition: all 0.3s;
        -o-transition: all 0.3s;
        transition: all 0.3s;
    }
    .input-popup::after {
        position: absolute;
        content: '';
        bottom: -19px;
        left: 50%;
        margin-left: -5px;
        border-width: 10px 10px 10px 10px;
        border-style: solid;
        border-color: transparent transparent #1a1a1a transparent;
        -webkit-transform: rotate(180deg);
        -ms-transform: rotate(180deg);
        transform: rotate(180deg);
    }
    .input-popup p {
        padding-left: 20px;
        position: relative;
    }
    .input-popup p::before {
        position: absolute;
        content: '';
        font-family: 'Line Awesome Free';
        font-weight: 900;
        left: 0;
        top: 4px;
        line-height: 1;
        font-size: 18px;
    }
    .input-popup p.error {
        text-decoration: line-through;
    }
    .input-popup p.error::before {
        content: "\f057";
        color: #ea5455;
    }
    .input-popup p.success::before {
        content: "\f058";
        color: #28c76f;
    }
</style>
@endpush
@push('script-lib')
<script src="{{ asset('assets/global/js/secure_password.js') }}"></script>
@endpush
@push('script')
    <script>
      "use strict";
        function submitUserForm() {
            var response = grecaptcha.getResponse();
            if (response.length == 0) {
                document.getElementById('g-recaptcha-error').innerHTML = '<span class="text-danger">@lang("Captcha field is required.")</span>';
                return false;
            }
            return true;
        }
        (function ($) {

            $('#companyAccount').on('click',function () { 
                $('.company-name').removeClass('d-none')
                $('.company-name').find('input[name=company_name]').removeAttr('disabled').attr('required','required')
                $('.firstname').text('@lang('Representative First Name')')
                $('.lastname').text('@lang('Representative Last Name')')
            })
            $('#personalAccount').on('click',function () { 
                $('.company-name').addClass('d-none')
                $('.company-name').find('input[name=company_name]').attr('disabled',true)
                $('.firstname').text('@lang('First Name')')
                $('.lastname').text('@lang('Last Name')')
            })

            @if($mobile_code)
            $(`option[data-code={{ $mobile_code }}]`).attr('selected','');
            @endif

            $('select[name=country]').change(function(){
                $('input[name=mobile_code]').val($('select[name=country] :selected').data('mobile_code'));
                $('input[name=country_code]').val($('select[name=country] :selected').data('code'));
                $('.mobile-code').text('+'+$('select[name=country] :selected').data('mobile_code'));
            });
            $('input[name=mobile_code]').val($('select[name=country] :selected').data('mobile_code'));
            $('input[name=country_code]').val($('select[name=country] :selected').data('code'));
            $('.mobile-code').text('+'+$('select[name=country] :selected').data('mobile_code'));
            @if($general->secure_password)
                $('input[name=password]').on('input',function(){
                    secure_password($(this));
                });
            @endif

            $('.checkUser').on('focusout',function(e){
                var url = '{{ route('user.checkUser') }}';
                var value = $(this).val();
                var token = '{{ csrf_token() }}';
                if ($(this).attr('name') == 'mobile') {
                    var mobile = `${$('.mobile-code').text().substr(1)}${value}`;
                    var data = {mobile:mobile,_token:token}
                }
                if ($(this).attr('name') == 'email') {
                    var data = {email:value,_token:token}
                }
                if ($(this).attr('name') == 'username') {
                    var data = {username:value,_token:token}
                }
                $.post(url,data,function(response) {
                  if (response['data'] && response['type'] == 'email') {
                    $('#existModalCenter').modal('show');
                  }else if(response['data'] != null){
                    $(`.${response['type']}Exist`).text(`${response['type']} already exist`);
                  }else{
                    $(`.${response['type']}Exist`).text('');
                  }
                });
            });

        })(jQuery);

    </script>
@endpush
