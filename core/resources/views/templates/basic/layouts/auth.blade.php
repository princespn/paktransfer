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
  <link rel="stylesheet" href="{{asset($activeTemplateTrue.'css/main.css')}}">
  <link href="{{ asset($activeTemplateTrue.'color/color.php') }}?color={{$general->base_color}}" rel="stylesheet" />
  @stack('style-lib')

  @stack('style')
</head>
  <body>
    @stack('fbComment')
   
    <div class="main-wrapper">
      
        @yield('content')
      
    </div>

 @php
    $cookie = App\Models\Frontend::where('data_keys','cookie.data')->first();
 @endphp

@if ($cookie->data_values->status == 1)
    <div class="cookies-card bg--default radius--10px text-center cookies--dark style--lg {{session('cookie_accepted') ? 'd-none':''}}">
        <div class="cookies-card__icon">
            <i class="fas fa-cookie-bite"></i>
        </div>
        <p class="mt-4 cookies-card__content"> @php echo @$cookie->data_values->description @endphp</p>
        <div class="cookies-card__btn mt-4">
            <a href="javascript:void(0)" class="cookies-btn left--btn policy">@lang('Allow')</a>
        </div>
    </div>
@endif

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
   <script src="{{asset($activeTemplateTrue.'js/app.js')}}"></script>

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

            $('.policy').on('click',function(){
                $.ajaxSetup({
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    }
                });
                $.get('{{route('cookie.accept')}}', function(response){
                    iziToast.success({message: response, position: "topRight"});
                    $('.cookies-card').addClass('d-none');
                });
            });
           
        })(jQuery)
    </script>

   </body>
 </html> 