@extends($activeTemplate.'layouts.frontend')
@php
    $content = getContent('login.content',true)->data_values;
@endphp
@section('content')

<section class="pt-100 pb-100 d-flex flex-wrap align-items-center justify-content-center">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-12">
          <div class="account-wrapper">
            <div class="left bg_img" style="background-image: url('{{getImage('assets/images/frontend/login/'.@$content->background_image,'768x1200')}}');">

            </div>
            <div class="right">
              <div class="inner">
                <div class="text-center">
                  <h2 class="title">{{__($pageTitle)}}</h2>
                  <p class="font-size--14px mt-1">@lang('Enter your email and we’ll help you create a new password.')</p>
                </div>
                <form class="account-form mt-5" method="POST" action="{{ route('user.password.email') }}">
                    @csrf
                    <div class="form-group">
                        <label>@lang('Select One')</label>
                        <select class="form--control" name="type" required>
                            <option value="email">@lang('E-Mail Address')</option>
                            <option value="username">@lang('Username')</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="my_value"></label>
                        <input type="text" class="form--control @error('value') is-invalid @enderror" name="value" value="{{ old('value') }}" required autofocus="off">

                        @error('value')
                            <span class="invalid-feedback" role="alert">
                                <strong>{{ $message }}</strong>
                            </span>
                        @enderror
                     
                    </div>
                
                  <div class="form-group">
                    <button type="submit" class="btn btn--base w-100">@lang('Send Password Code')</button>
                  </div>
                </form>
              
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
</section>
@endsection
@push('script')
<script>

    (function($){
        "use strict";
        
        myVal();
        $('select[name=type]').on('change',function(){
            myVal();
        });
        function myVal(){
            $('.my_value').text($('select[name=type] :selected').text());
        }
    })(jQuery)
</script>
@endpush