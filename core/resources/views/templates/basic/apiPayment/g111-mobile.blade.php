<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link rel="icon" href="{{get_image(config('constants.logoIcon.path') .'/favicon.png')}}" type="image/x-icon">
    <link rel="shortcut icon" type="image/png" href="{{ get_image(config('constants.logoIcon.path') .'/favicon.png') }}"/>
    <title>{{ $general->sitename($page_title ?? '') }} @yield('title')</title>
@include('partials.seo')
<!-- Bootstrap -->
    <link href="{{asset('assets/template/basic/css/bootstrap.min.css')}}" rel="stylesheet">
    @yield('import-css')
    <link href="{{asset('assets/template/basic/css/font-awesome.min.css')}}" rel="stylesheet">
    <link href="{{asset('assets/template/basic/css/owl.carousel.min.css')}}" rel="stylesheet">
    <link href="{{asset('assets/template/basic/css/themify-icons.css')}}" rel="stylesheet">
    <link href="{{asset('assets/template/basic/css/nice-select.css')}}" rel="stylesheet">
    @include('partials.notify-css')

    <link href="{{asset('assets/template/basic/css/invoice.css')}}" rel="stylesheet">
    <!-- Main css -->
    <link href="{{asset('assets/template/basic/css/main.css')}}" rel="stylesheet">

@yield('style')

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="https://js.stripe.com/v3/"></script>
    <style>
        .StripeElement {
            box-sizing: border-box;
            height: 40px;
            padding: 10px 12px;
            border: 1px solid transparent;
            border-radius: 4px;
            background-color: white;
            box-shadow: 0 1px 3px 0 #e6ebf1;
            -webkit-transition: box-shadow 150ms ease;
            transition: box-shadow 150ms ease;
        }

        .StripeElement--focus {
            box-shadow: 0 1px 3px 0 #cfd7df;
        }

        .StripeElement--invalid {
            border-color: #fa755a;
        }

        .StripeElement--webkit-autofill {
            background-color: #fefde5 !important;
        }
    </style>
</head>
<body>
<!--Dashboard area-->
<section class="section-padding gray-bg blog-area height-100vh">
    <div class="container">
        <div class="row dashboard-content">
            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                <div class="dashboard-inner-content">

                    <div class="row justify-content-center">
                        <div class="col-lg-8 col-md-8 mb-4">

                            <div class="card text-center">

                                <div class="card-header">@lang('Stripe Payment - Final Step')</div>


                                <div class="card-body">

                                    <div class="row">
                                        <div class="col-md-4">
                                            <img src="{{get_image(config('constants.deposit.gateway.path') .'/'. $deposit->gateway->image) }}" style="width:100%;"/>
                                        </div>
                                        <div class="col-md-8">
                                            <h3 class="mt-3 mb-3 ">@lang('Please Send') <span class="text-success">{{$deposit->final_amo}} {{$deposit->method_currency}}</span></h3>


                                            <form action="{{$url}}" method="{{$method}}">
                                                <script
                                                    src="{{$src}}"
                                                    class="stripe-button custom-btn mt-5"
                                                    @foreach($val as $key=> $value)
                                                    data-{{$key}}="{{$value}}"
                                                    @endforeach
                                                >
                                                </script>
                                            </form>

                                        </div>
                                    </div>


                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section><!--/Dashboard area-->


@include(activeTemplate().'partials.footer')

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="{{asset('assets/template/basic/js/jquery-3.2.1.min.js')}}"></script>
<script src="{{asset('assets/template/basic/js/jquery-migrate.js')}}"></script>

<script src="{{asset('assets/template/basic/js/popper.js')}}"></script>
<script src="{{asset('assets/template/basic/js/bootstrap.min.js')}}"></script>
@yield('import-js')

<script src="{{asset('assets/template/basic/js/owl.carousel.min.js')}}"></script>
<script src="{{asset('assets/template/basic/js/parallax.min.js')}}"></script>

<script src="{{asset('assets/template/basic/js/waypoints.min.js')}}"></script>
<script src="{{asset('assets/template/basic/js/jquery.counterup.min.js')}}"></script>
<script src="{{asset('assets/template/basic/js/scrollUp.min.js')}}"></script>

<script src="{{asset('assets/template/basic/js/particles.min.js')}}"></script>
<script src="{{asset('assets/template/basic/js/particle-app.js')}}"></script>
<script src="{{asset('assets/template/basic/js/jquery.nice-select.min.js')}}"></script>


@if($general->alert == 1)
    <script src="{{ asset('assets/admin/js/iziToast.min.js') }}"></script>
    @if(session()->has('notify'))
        @foreach(session('notify') as $msg)
            <script type="text/javascript">  iziToast.{{ $msg[0] }}({message:"{{ $msg[1] }}", position: "topRight"}); </script>
        @endforeach
    @endif


@elseif($general->alert == 2)
    <!-- Toastr -->
    <script src="{{ asset('assets/admin/js/toastr.min.js') }}"></script>
    @if(session()->has('notify'))
        @foreach(session('notify') as $msg)
            <script type="text/javascript">  toastr.{{ $msg[0] }}("{{ $msg[1] }}"); </script>
        @endforeach
    @endif

@endif

<script src="{{asset('assets/template/basic/js/script.js')}}"></script>
@yield('script')
</body>
</html>


