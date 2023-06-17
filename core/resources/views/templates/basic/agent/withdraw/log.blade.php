@extends($activeTemplate.'layouts.agent_master')

@section('content')
<div class="row justify-content-center mt-5">
    <div class="custom--card">
        <div class="card-body">
            <div class="row align-items-center mb-3">
                <div class="col-6">
                    <h6>@lang($pageTitle)</h6>
                </div>
                <div class="col-6 text-end">
                    
                </div>
            </div>
            <div class="table-responsive--sm">
                <table class="table custom--table">
                    <thead>
                        <tr>
                            <th>@lang('Transaction ID')</th>
                            <th>@lang('Withdraw Method')</th>
                            <th>@lang('Amount')</th>
                            <th>@lang('Charge')</th>
                            <th>@lang('Receivable')</th>
                            <th>@lang('Status')</th>
                            <th>@lang('Time')</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($withdraws as $k=>$data)
                        <tr>
                            <td data-label="#@lang('Trx')">{{$data->trx}}</td>
                            <td data-label="@lang('Gateway')">{{ __($data->method->name) }}</td>
                            <td data-label="@lang('Amount')">
                                <strong>{{showAmount($data->amount,$data->curr)}} {{$data->curr->currency_code}}</strong>
                            </td>
                            <td data-label="@lang('Charge')" class="text-danger">
                                {{showAmount($data->charge,$data->curr)}} {{$data->curr->currency_code}}
                            </td>
                                                    
                            <td data-label="@lang('Receivable')" class="text-success">
                                <strong>{{showAmount($data->final_amount,getCurrency($data->currency))}} {{__($data->currency)}}</strong>
                            </td>
                            <td data-label="@lang('Status')">
                                @if($data->status == 2)
                                    <span class="badge badge--warning">@lang('Pending')</span>
                                @elseif($data->status == 1)
                                    <span class="badge badge--success">@lang('Completed')</span>
                                    <button class="btn-info btn-rounded  badge approveBtn" data-admin_feedback="{{$data->admin_feedback}}"><i class="fa fa-info"></i></button>
                                @elseif($data->status == 3)
                                    <span class="badge badge--danger">@lang('Rejected')</span>
                                    <button class="btn-info btn-rounded badge approveBtn" data-admin_feedback="{{$data->admin_feedback}}"><i class="fa fa-info"></i></button>
                                @endif

                            </td>
                            <td data-label="@lang('Time')">
                                <i class="fa fa-calendar"></i> {{showDateTime($data->created_at)}}
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td class="text-muted text-center" colspan="100%">{{ __($emptyMessage) }}</td>
                        </tr>
                    @endforelse
                     
                    </tbody>
                </table>
            </div>
            {{paginateLinks($withdraws)}}
        </div>
    </div><!-- custom--card end -->

    {{-- Detail MODAL --}}
    <div id="detailModal" class="modal fade" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">@lang('Details')</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">

                    <div class="withdraw-detail"></div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn--dark btn-sm" data-bs-dismiss="modal">@lang('Close')</button>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@push('script')
    <script>
        (function($){
            "use strict";
            $('.approveBtn').on('click', function() {
                var modal = $('#detailModal');
                var feedback = $(this).data('admin_feedback');
                modal.find('.withdraw-detail').html(`<p> ${feedback} </p>`);
                modal.modal('show');
            });
        })(jQuery);

    </script>
@endpush
