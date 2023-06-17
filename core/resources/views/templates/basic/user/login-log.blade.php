@extends(activeTemplate().'layouts.user')
@section('title','')
@section('content')


    <!--Dashboard area-->
    <section class="section-padding gray-bg blog-area">
        <div class="container">
            <div class="row">

                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                    <div class="dashboard-content">
                        <div class="row">
                            <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                                <div class="dashboard-inner-content">
                                    <div class="card bg-white">
                                        <h5 class="card-header">{{__($page_title)}}</h5>
                                        <div class="card-body mt-2 ">


                                            <div class="table-responsive table-responsive-xl table-responsive-lg table-responsive-md table-responsive-sm">
                                                <table class="table table-striped mb-0 cmn-table">
                                                    <thead class="thead-dark">
                                                    <tr>
                                                        <th scope="col">@lang('IP')</th>
                                                        <th scope="col">@lang('Browser')</th>
                                                        <th scope="col" class="text-right">@lang('Time')</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    @if(count($loginLogs) >0)
                                                        @foreach($loginLogs as $k=>$data)
                                                            <tr>
                                                                <td data-label="@lang('IP')">{{$data->user_ip}}</td>
                                                                <td data-label="@lang('Browser')">{{$data->browser}}</td>
                                                                <td data-label="@lang('Time')" class="text-right">
                                                                    <i class="far fa-calendar-alt"></i> {{date('d M, Y ', strtotime($data->created_at))}}
                                                                    <i class="far fa-clock"></i> {{date('h:i A', strtotime($data->created_at))}}
                                                                </td>
                                                            </tr>
                                                        @endforeach
                                                        <tr>
                                                            <td colspan="3">
                                                                <a href="javascript:void(0)" class="btn custom-btn mb-0 float-right"  data-toggle="modal" data-target="#exampleModal">@lang('Logout All Other Devices')</a>
                                                            </td>
                                                        </tr>
                                                    @else
                                                        <tr>
                                                            <td colspan="3"><p> @lang('No results found')</p></td>
                                                        </tr>
                                                    @endif
                                                    </tbody>
                                                </table>
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




    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">@lang('Logout Others Device')</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <form action="{{route('user.logoutOthers')}}" method="post">
                    @csrf
                <div class="modal-body">
                    <div class="form-group bosao-button mb-0">
                        <label>@lang('Enter Your Password')</label>
                        <input type="password" name="password" class="form-control">
                        <button type="submit" class="btn btn-success dyna-bg">@lang('Confirm')</button>
                    </div>
                </div>
                </form>
            </div>
        </div>
    </div>

@endsection
