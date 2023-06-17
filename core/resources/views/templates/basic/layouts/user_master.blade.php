<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title> {{ $general->sitename(__($pageTitle)) }}</title>
    @include('partials.seo')
  <link rel="shortcut icon" type="image/png" href="{{asset($activeTemplateTrue.'images/favicon.png')}}">
  <!-- bootstrap 4  -->

  <link rel="stylesheet" href="{{asset('assets/global/css/bootstrap.min.css')}}">
  <!-- fontawesome 5  -->
  <link rel="stylesheet" href="{{asset('assets/global/css/all.min.css')}}"> 
  <!-- lineawesome font -->
  <link rel="stylesheet" href="{{asset('assets/global/css/line-awesome.min.css')}}"> 
  <link rel="stylesheet" href="{{asset('assets/global/css/lightcase.css')}}"> 
  <!-- slick slider css -->
  <link rel="stylesheet" href="{{asset('assets/global/css/slick.css')}}">
  <!-- main css -->
  <link rel="stylesheet" href="{{asset($activeTemplateTrue.'agent/css/main.css')}}">
  <link href="{{ asset($activeTemplateTrue.'color/color.php') }}?color={{$general->base_color}}" rel="stylesheet">
  @stack('style-lib')

  @stack('style')
</head>
  <body> 
    @stack('fbComment')
    <div class="agent-dashboard">
        @include($activeTemplate.'partials.user_header_new') 
        <div class="dashboard-top-nav">
            <div class="row align-items-center">
                <div class="col-2">
                    <button class="sidebar-open-btn"><i class="las la-bars"></i></button>
                </div>
                <div class="col-10">
                  <div class="d-flex flex-wrap justify-content-end align-items-center">
                    <ul class="header-top-menu">
                      <li><a href="{{route('ticket')}}">@lang('Support Ticket')</a></li>
                     
                    </ul>
                    <div class="header-user">
                      <span class="thumb"></span>
                      <span class="name">{{auth()->user()->username}}</span>
                      
                    <ul class="header-user-menu">
                      <li><a href="{{route('user.profile.setting')}}"><i class="las la-user-circle"></i> @lang('Profile')</a></li>
                      <li><a href="{{route('user.change.password')}}"><i class="las la-cogs"></i>@lang('Change Password')</a></li>
                      <li><a href="{{route('user.twofactor')}}"><i class="las la-bell"></i>@lang('2FA Security')</a></li>
                      <li><a href="{{route('user.qr')}}">  <i class="las la-qrcode"></i>@lang('My QRcode')</a></li>
                      <li><a href="{{route('user.logout')}}"><i class="las la-sign-out-alt"></i>@lang('Logout')</a></li>
                    </ul>
                    </div>
                  </div>
                </div>
            </div>
        </div>          
        <div class="agent-dashboard__body">
          <div class="row justify-content-center mt-5">
            @yield('content')
          </div>
        </div>
    </div>

   <!-- jQuery library -->
   <script src="{{asset('assets/global/js/jquery-3.6.0.min.js')}}"></script>
   <!-- bootstrap js -->
   <script src="{{asset('assets/global/js/bootstrap.bundle.min.js')}}"></script>
   <!-- slick slider js -->
   <script src="{{asset('assets/global/js/slick.min.js')}}"></script>
   <!-- scroll animation -->
   <script src="{{asset('assets/global/js/wow.min.js')}}"></script>
   <!-- lightcase js -->
   <script src="{{asset('assets/global/js/lightcase.min.js')}}"></script>
   <script src="{{asset('assets/global/js/jquery.paroller.min.js')}}"></script>
   <!-- main js -->
   <script src="{{asset($activeTemplateTrue.'agent/js/app.js')}}"></script>
   <script src="{{asset('assets/global/js/jquery.slimscroll.min.js')}}"></script>

   @stack('script-lib')

    @stack('script')

    @include('partials.plugins')

    @include('partials.notify')


    <script>
        (function ($) {
            "use strict";
            $(".langSel").on("change", function() {
                window.location.href = "{{route('home')}}/change/"+$(this).val() ;
            });
           
        })(jQuery)
    </script>
   </body>
 </html> 