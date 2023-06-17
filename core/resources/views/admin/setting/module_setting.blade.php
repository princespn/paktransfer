@extends('admin.layouts.app')

@section('panel')

    @csrf
    <div class="row">
            <div class="col-md-6 mb-3">
                <div class="card">
                    <div class="card-header bg--primary">
                       <h3 class="text-white"><i class="las la-user-friends"></i> @lang('User Modules')</h3>
                    </div>
                    <div class="card-body">
                        <ul class="list-group">
                            @foreach ( $modules->where('user_type','USER') as $module)
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <strong>{{ucwords(str_replace('_',' ',$module->slug))}}</strong>
                                <div class="form-group mb-0">
                                    <div class="custom-control custom-switch">
                                        <input type="checkbox"{{$module->status == 1 ? ' checked':''}}  data-id="{{$module->id}}" class="custom-control-input update" id="customSwitch-{!! $module->id !!}">
                                        <label class="custom-control-label" for="customSwitch-{!! $module->id !!}"></label>
                                    </div>
                                </div>
                            </li>
                            @endforeach
                            </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-3">
                <div class="card">
                    <div class="card-header bg--dark">
                       <h3 class="text-white"><i class="las la-user-secret"></i> @lang('Agent Modules')</h3>
                    </div>
                    <div class="card-body">
                        <ul class="list-group">
                            @foreach ( $modules->where('user_type','AGENT') as $module)
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <strong>{{ucwords(str_replace('_',' ',$module->slug))}}</strong>
                                <div class="form-group mb-0">
                                    <div class="custom-control custom-switch">
                                        <input type="checkbox"{{$module->status == 1 ? ' checked':''}}  data-id="{{$module->id}}" class="custom-control-input update" id="customSwitch-{!! $module->id !!}">
                                        <label class="custom-control-label" for="customSwitch-{!! $module->id !!}"></label>
                                    </div>
                                </div>
                            </li>
                            @endforeach
                            </ul>
                    </div>
                </div>

                <div class="card mt-4">
                    <div class="card-header bg--secondary">
                       <h3 class="text-white"><i class="las la-user-tie"></i>  @lang('Merchant Modules')</h3>
                    </div>
                    <div class="card-body">
                        <ul class="list-group">
                            @foreach ( $modules->where('user_type','MERCHANT') as $module)
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <strong>{{ucwords(str_replace('_',' ',$module->slug))}}</strong>
                                <div class="form-group mb-0">
                                    <div class="custom-control custom-switch">
                                        <input type="checkbox"{{$module->status == 1 ? ' checked':''}}  data-id="{{$module->id}}" class="custom-control-input update" id="customSwitch-{!! $module->id !!}">
                                        <label class="custom-control-label" for="customSwitch-{!! $module->id !!}"></label>
                                    </div>
                                </div>
                            </li>
                            @endforeach
                            </ul>
                    </div>
                </div>
            </div>

        </div>



@endsection

@push('script')
     <script>
            'use strict';
            (function ($) {
               $('.update').on('change', function () {
                var url = "{{route('admin.module.update')}}"
                var id = $(this).data('id')
                var token = "{{csrf_token()}}"
                var data = {
                    id:id,
                    _token:token
                }
                $.post(url,data,function(response) {
                    notify('success',response.success)
                })
               });
            })(jQuery);
     </script>
@endpush
