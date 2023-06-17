@extends(activeTemplate().'layouts.user')
@section('title','')
@section('content')
    <!--Dashboard area-->
    <section class="section-padding blog-area">
        <div class="container">
            <div class="row">


                @include(activeTemplate().'partials.myWallet')

                <div class="col-md-9">
                    <div class="dashboard-content">
                        <div class="row">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                <div class="dashboard-inner-content">
                                    <div class="card">
                                        <div class="card-header align-items-center">
                                            <h5 class="card-title m-0">{{__($page_title)}}</h5>
                                        </div>
                                        <div class="card-body p-0">

                                            <div class="accordion" id="accordionExample">

                                                @foreach($transactions as $k=> $data)
                                                <div class="card">
                                                    <div class="t-log-title ">
                                                        <div data-toggle="collapse" data-target="#collapse{{$data->id}}" aria-expanded="true" aria-controls="collapse{{$data->id}}">
                                                            <div class="row">
                                                                <div class="col-2 col-sm-3 col-md-1">
                                                                    <div class="date-site">
                                                                        <span class="d-block">{{date('M', strtotime($data->created_at))}}</span>
                                                                        <span class="d-block">{{date('d', strtotime($data->created_at))}}</span>
                                                                    </div>
                                                                </div>
                                                                <div class="col-6 col-sm-6 col-md-8">
                                                                    <p>{{__($data->remark)}}</p>
                                                                    <p>{{__($data->title)}}</p>
                                                                </div>
                                                                <div class="col-4 col-sm-3 col-md-3">
                                                                    <div class="trans-amnt @if($data->type == '-')text-danger @else text-success @endif">
                                                                        @if($data->type == '-')- @else + @endif {{formatter_money($data->amount)}} {{($data->currency) ? $data->currency->code : ''}}
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div id="collapse{{$data->id}}" class="collapse" aria-labelledby="heading{{$data->id}}" data-parent="#accordionExample">
                                                        <div class="card-body pad-15">
                                                            <div class="row">
                                                                <div class="col col-sm-4 col-md-4">
                                                                    <p>{{ $data->remark}}:</p>
                                                                </div>
                                                                <div class="col col-sm-4 col-md-4">
                                                                    <p><strong>{{formatter_money($data->amount)}} {{($data->currency) ? $data->currency->code : ''}}</strong></p>
                                                                </div>
                                                                <div class="col col-sm-4 col-md-4">
                                                                    <strong>@lang('Transaction ID'):</strong>
                                                                    <small>{{$data->trx}}</small>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col col-sm-4 col-md-4">
                                                                    <p>@lang('Charge'):</p>
                                                                </div>
                                                                <div class="col col-sm-6 col-md-6">
                                                                    <p><strong>{{formatter_money($data->charge)}} {{($data->currency) ?  $data->currency->code : ''}}</strong></p>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col col-sm-4 col-md-4">
                                                                    <p>@lang('Remaining Balance'):</p>
                                                                </div>
                                                                <div class="col col-sm-6 col-md-6">
                                                                    <p><strong>{{formatter_money($data->main_amo)}}  {{($data->currency) ?  $data->currency->code : ''}}</strong></p>
                                                                </div>
                                                            </div>
                                                            <div class="row">
                                                                <div class="col col-sm-4 col-md-4">
                                                                    <p>@lang('Details'):</p>
                                                                </div>
                                                                <div class="col col-sm-4 col-md-4">
                                                                    <p>{{$data->title}}</p>
                                                                </div>
                                                                <div class="col col-sm-4 col-md-4">
                                                                    <p><small class="mr-2"><i class="fa fa-calendar-o"></i> {{date(' d M, Y ', strtotime($data->created_at)) }}</small> <small><i class="fa fa-clock-o"></i> {{ date('H:i A ', strtotime($data->created_at))}}</small></p>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                @endforeach
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-5">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                {{ $transactions->appends($_GET)->links('partials.pagination') }}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section><!--/Dashboard area-->




@endsection

@section('import-css')

    <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css" />
@stop

@section('import-js')

    <script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
@stop

@section('script')
@stop
