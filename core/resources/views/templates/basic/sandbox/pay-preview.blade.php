@extends(activeTemplate().'layouts.master')
@section('style')
    <style>
        .breadcrumb-area.fixed-head {
            padding: 200px 0 150px 0;
        }
    </style>
@stop
@section('content')
    <!--breadcrumb area-->
    <section class="breadcrumb-area fixed-head gradient-overlay">
        <div id="particles-js"></div>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-8 col-lg-8 col-md-12 col-sm-12 centered">
                    <div class="banner-title">
                        <h2>{{__($page_title)}}</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>



    <section class="section-padding pb-5" >
        <div class="container">

            <div class="row justify-content-center">

                <div class="col-lg-12">
                    <div class="contact-form-area form-area">
                        <div class="row mb-4 justify-content-center">
                            <div class="col-lg-3">
                                <div class="text-center py-4 pl-3">
                                    <a href="javascript:void(0)">
                                        <img src="{{get_image(config('constants.logoIcon.path') .'/logo.png')}}" alt="logo" class="logo-default" style="max-width: 100%;">
                                    </a>
                                </div>
                            </div>
                        </div>

                        <div class="row justify-content-center">
                            <div class="col-lg-6">
                                <h4 class="text-center">@lang('Send For') - <span
                                        class="text-danger">{{$allData->details}}</span></h4>
                            </div>
                            <div class="col-lg-12">
                                <h2 class="text-dark text-center mt-4">
                                    @lang('Payable Amount') :  {{$allData->amount}} {{$allData->currency}}</h2>

                            </div>
                        </div>



                        <div class="row my-3 justify-content-center">

                            <div class="col-2">
                                <a href="{{route('express.sandbox.confirm')}}"  onclick="event.preventDefault();
                                                     document.getElementById('success-IPN').submit();" class="btn btn-success">@lang('Pay Confirm')</a>



                                <form id="success-IPN" action="{{route('express.sandbox.confirm')}}" method="POST" style="display: none">
                                </form>

                            </div>

                            <div class="col-2">
                                <a href="{{url($allData->cancel_url)}}" class="btn btn-danger">@lang('Cancel Confirm')</a>
                            </div>


                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>




@endsection

@section('js')

@endsection
