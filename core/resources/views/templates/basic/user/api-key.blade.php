@extends(activeTemplate().'layouts.user')
@section('title','')
@section('import-css')
@stop
@section('content')
    <!--Dashboard area-->
    <section class="section-padding gray-bg">
        <div class="container">
            <div class="row">

                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                    <div class="dashboard-content">
                        <div class="row">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                <div class="dashboard-inner-content">
                                    <div class="card bg-white">
                                        <div class="card-header">
                                            <h3 class="card-title">{{__($page_title)}}</h3>
                                            <button class="btn btn-success dyna-bg float-right" data-toggle="modal" data-target="#keyModal">@lang('Generate Key')</button>

                                        </div>
                                        <div class="card-body">
                                                <div class="row justify-content-end">
                                                    <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">

                                                        <div id="accordion">
                                                            @if(count($user->api_keys) > 0)
                                                            @foreach($user->api_keys as $k => $val)
                                                            <div class="card bg-white mb-2">
                                                                <div class="card-header" id="heading{{$k}}">
                                                                    <h5 class="mb-0 w-100 d-flex flex-wrap justify-content-between">
                                                                        {{$val->name}}
                                                                        <button class="btn btn-danger delete-key float-right" data-id="{{$val->id}}" data-toggle="modal" data-target="#DelKeyModal"><i class="fa fa-trash"></i></button>
                                                                    </h5>
                                                                </div>

                                                                <div class="collapse show " aria-labelledby="heading{{$k}}" data-parent="#accordion">
                                                                    <div class="card-body ">

                                                                        <p class="text-dark">@lang('Public Key') :  <strong class="text-dark">{{$val->public_key}}</strong></p>
                                                                        <p class="mb-0 text-dark">@lang('Secret Key') :  <strong class="text-dark">{{$val->secret_key}}</strong></p>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            @endforeach

                                                            @else

                                                            <p class="text-white ">@lang('No API Key Found!')</p>
                                                            @endif

                                                               @lang('Get Your  API Documentation') <a href="{{route('documentation')}}" class="text-info my-3">@lang('Click Here')</a>

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

            </div>
        </div>
    </section><!--/Dashboard area-->


    <!-- Add Modal -->
    <div class="modal fade" id="keyModal" tabindex="-1" role="dialog" aria-labelledby="keyModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="keyModalLabel">@lang('Generate New Key')</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <form action="" method="post">
                    @csrf
                    <div class="modal-body">
                        <div class="form-group bosao-button mb-0">
                            <label>@lang('Name')</label>
                            <input type="text" class="form-control" name="name" value="{{old('name')}}">
                        <button type="submit" class="btn btn-success dyna-bg">@lang('Key Generate')</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <!-- Delete Modal -->

    <div class="modal fade" id="DelKeyModal" tabindex="-1" role="dialog" aria-labelledby="keyModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="keyModalLabel">@lang('Generate New Key')</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <form action="" method="post">
                    @csrf
                    @method('delete')
                    <div class="modal-body">
                        <input type="hidden" name="id" class="deleted-id">
                        <p>@lang('If you want to delete this, you will not make transaction this credentials')</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">@lang('Close')</button>
                        <button type="submit" class="btn btn-danger">@lang('Remove')</button>
                    </div>
                </form>
            </div>
        </div>
    </div>



@endsection

@section('script')
    <script>
        $(document).ready(function () {

            $('.delete-key').on('click', function () {
               $('.deleted-id').val($(this).data('id'));
            })

        })
    </script>

@endsection
