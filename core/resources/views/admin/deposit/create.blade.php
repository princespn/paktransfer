@extends('admin.layouts.app')

@section('panel')
<div class="row">

    <div class="col-lg-12">
        <div class="card">
            <form action="{{ route('admin.deposit.manual.store') }}" method="POST" enctype="multipart/form-data">
                @csrf
                <div class="card-body" >
                    <div class="payment-method-item">
                        <div class="payment-method-header d-flex flex-wrap">
                            <div class="thumb">
                                <div class="avatar-preview">
                                    <div class="profilePicPreview"></div>
                                </div>
                                <div class="avatar-edit">
                                    <input type="file" name="image" class="profilePicUpload" id="image" accept=".png, .jpg, .jpeg" />
                                    <label for="image" class="bg-primary"><i class="fa fa-pencil"></i
                                    ></label>
                                </div>
                            </div>
                            <div class="content">
                                <div class="d-flex justify-content-between">
                                    <input type="text" class="form-control" placeholder="Method Name" name="name" value="{{ old('name') }}" />
                                </div>
                                <div class="row mt-4">
                                    <div class="col-md-4">
                                        <div class="input-group">
                                            <label class="w-100">Currency <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" name="currency" class="form-control border-radius-5" value="{{ old('currency') }}" />
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="w-100">Rate <span class="text-danger">*</span></label>

                                        <div class="input-group has_append">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text"><b>1</b> &nbsp; <span class="currency_symbol"> </span>  &nbsp;  = </div>
                                            </div>
                                            <input type="text" class="form-control" placeholder="0" name="rate" value="{{ old('rate') }}" />
                                            <div class="input-group-append">
                                                <div class="input-group-text"> {{ $general->cur_text }}</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <label class="w-100">Delay <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" name="delay" class="form-control border-radius-5" value="{{ old('delay') }}" />
                                    </div>
                                </div>


                            </div>
                        </div>
                        <div class="payment-method-body">
                            <div class="row">

                                <div class="col-lg-6">
                                    <div class="card outline-primary">
                                        <h5 class="card-header bg-primary">Range</h5>
                                        <div class="card-body">
                                            <div class="input-group mb-3">
                                                <label class="w-100">Minimum Amount <span class="text-danger">*</span></label>
                                                <div class="input-group-prepend">
                                                    <div class="input-group-text">{{ $general->cur_text }}</div>
                                                </div>
                                                <input type="text" class="form-control" name="min_limit" placeholder="0" value="{{ old('min_limit') }}" />
                                            </div>
                                            <div class="input-group">
                                                <label class="w-100">Maximum Amount <span class="text-danger">*</span></label>
                                                <div class="input-group-prepend">
                                                    <div class="input-group-text">{{ $general->cur_text }}</div>
                                                </div>
                                                <input type="text" class="form-control" placeholder="0" name="max_limit" value="{{ old('max_limit') }}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="card outline-primary">
                                        <h5 class="card-header bg-primary">Charge</h5>
                                        <div class="card-body">
                                            <div class="input-group mb-3">
                                                <label class="w-100">Fixed Charge <span class="text-danger">*</span></label>
                                                <div class="input-group-prepend">
                                                    <div class="input-group-text">{{ $general->cur_text }}</div>
                                                </div>
                                                <input type="text" class="form-control" placeholder="0" name="fixed_charge" value="{{ old('fixed_charge') }}"/>
                                            </div>
                                            <div class="input-group">
                                                <label class="w-100">Percent Charge <span class="text-danger">*</span></label>
                                                <div class="input-group-prepend">
                                                    <div class="input-group-text">%</div>
                                                </div>
                                                <input type="text" class="form-control" placeholder="0" name="percent_charge" value="{{ old('percent_charge') }}">
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-12">
                                    <div class="card outline-dark">
                                        <div class="card-header bg-dark d-flex justify-content-between">
                                            <h5>Deposit Instruction</h5>
                                        </div>
                                        <div class="card-body">
                                            <div class="form-group">
                                                <textarea rows="8" class="form-control border-radius-5 nicEdit" name="instruction">{{ old('instruction') }}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-lg-12">
                                    <div class="card outline-dark">
                                        <div class="card-header bg-dark d-flex justify-content-between">
                                            <h5>User data</h5>
                                            <button type="button" class="btn btn-sm btn-outline-light addUserData"><i class="fa fa-fw fa-plus"></i>Add New</button>
                                        </div>
                                        <div class="card-body">
                                            <div class="form-row" id="userData">
                                                <div class="col-md-4 user-data mt-2">
                                                    <input type="text" class="form-control border-radius-5" name="verify_image" placeholder="Ask for Image Proof">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <button type="submit" class="btn btn-primary btn-block">Save Method</button>
                </div>
            </form>
        </div>
    </div>
</div>

@endsection


@push('breadcrumb-plugins')
<a href="{{ route('admin.deposit.manual.index') }}" class="btn btn-dark" ><i class="fa fa-fw fa-reply"></i>Back</a>
@endpush

@push('script')
<script>
$('input[name=currency]').on('input', function() {
    $('.currency_symbol').text($(this).val());
});
$('.addUserData').on('click', function() {
    var html =  `<div class="col-md-4 user-data mt-2">
                    <div class="input-group has_append">
                        <input class="form-control border-radius-5" name="ud[]" required>
                        <div class="input-group-append">
                            <button type="button" class="btn btn-danger removeBtn"><i class="fa fa-times"></i></button>
                        </div>
                    </div>
                </div>`;

    $('#userData').append(html);
});

$(document).on('click', '.removeBtn', function() {
    $(this).parents('.user-data').remove();
});
@if(old('currency'))
$('input[name=currency]').trigger('input');
@endif
</script>
@endpush
