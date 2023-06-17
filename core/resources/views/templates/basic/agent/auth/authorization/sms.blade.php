@extends($activeTemplate .'layouts.auth')
@php
    $content = getContent('agent_login.content',true)->data_values;
@endphp
@section('content')


<section class="account-section">
  <div class="left">
    <div class="left-inner w-100">
      <div class="text-center">
        <a class="site-logo" href="{{url('/')}}"><img src="{{ getImage(imagePath()['logoIcon']['path'] .'/dark_logo.png') }}" alt="logo"></a>
      </div>
      <form class="account-form mt-5" method="POST" action="{{route('agent.verify.sms')}}">
        @csrf
        <div class="form-group">
            <p class="text-center">@lang('Your Phone No.'):  <strong>{{agent()->mobile}}</strong></p>
        </div>

        <div class="form-group">
            <label>@lang('Verification Code')</label>
            <input type="text" name="sms_verified_code" class="form--control" maxlength="7" id="code" required>
       </div>

      <div class="form-group">
        <button type="submit" class="btn btn--base w-100">@lang('Submit')</button>
      </div>

      <div class="form-group">
        <small>@lang('Didn\'nt get code in your phone yet?')</small> 
        <small class="text-center"><a href="{{route('agent.send.verify.code')}}?type=sms" class="forget-pass"> @lang('Resend code')</a></small>
        @if ($errors->has('resend'))
            <br/>
            <small class="text-danger">{{ $errors->first('resend') }}</small>
        @endif
    </div>
    </form>
  
    </div>
  </div>
  <div class="right bg_img" style="background-image: url('{{getImage('assets/images/frontend/agent_login/'.@$content->background_image,'1920x1280')}}');">
  </div>
</section>



@endsection
@push('script')
<script>
    (function($){
        "use strict";
        $('#code').on('input change', function () {
          var xx = document.getElementById('code').value;
          $(this).val(function (index, value) {
             value = value.substr(0,7);
              return value.replace(/\W/gi, '').replace(/(.{3})/g, '$1 ');
          });
      });
    })(jQuery)
</script>
@endpush