@extends('admin.layouts.master')
@section('content')
    <div class="page-wrapper default-version">
        <div class="form-area bg_img" data-background="{{asset('assets/admin/images/1.jpg')}}">
            <div class="form-wrapper">
                <h4 class="logo-text mb-15">Log in to your Paktransfer account</strong></h4>
                <p>Don't have an account? <a href="{{route('user.register')}}">Register</a></p>
                <form action="{{ route('user.login') }}" method="POST" class="cmn-form mt-30">
                    @csrf
                    <div class="form-group">
                        <label for="email">@lang('Username or E-mail')</label>
                        <input type="text" name="username" class="form-control b-radius--capsule" id="username" value="{{ old('username') }}" placeholder="@lang('Enter your username or email')">
                        <i class="las la-user input-icon"></i>
                    </div>
                    <div class="form-group">
                        <label for="pass">@lang('Password')</label>
                        <input type="password" name="password" class="form-control b-radius--capsule" id="pass" placeholder="@lang('Enter your password')">
                        <i class="las la-lock input-icon"></i>
                    </div>
                    @include($activeTemplate.'partials.custom_captcha')
                     <div class="form-group">
                      @php echo loadReCaptcha() @endphp
                    </div>
                    <div class="form-group">
                        <button type="submit" class="submit-btn mt-25 b-radius--capsule">@lang('Login') <i class="las la-sign-in-alt"></i></button>
                    </div>
                    <div class="form-group d-flex justify-content-between align-items-center">
                        <a href="{{route('user.password.request')}}">@lang('Forgot Password?')</a>
                    </div>
                </form>
            </div>
        </div><!-- login-area end -->
    </div>
@endsection

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
    </script>
@endpush
