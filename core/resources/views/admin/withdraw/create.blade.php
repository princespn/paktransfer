@extends('admin.layouts.app')

@section('panel')
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <form action="{{ route('admin.withdraw.method.store') }}" method="POST" enctype="multipart/form-data">
                    @csrf
                    <div class="card-body">
                        <div class="payment-method-item">
                            <div class="payment-method-header">
                                <div class="thumb">
                                    <div class="avatar-preview">
                                        <div class="profilePicPreview" style="background-image: url({{getImage('/',imagePath()['withdraw']['method']['size'])}})"></div>
                                    </div>
                                    <div class="avatar-edit">
                                        <input type="file" name="image" class="profilePicUpload" id="image" accept=".png, .jpg, .jpeg"/>
                                        <label for="image" class="bg--primary"><i class="la la-pencil"></i></label>
                                    </div>
                                </div>
                                <div class="content">
                                    <div class="d-flex justify-content-between">
                                        <input type="text" class="form-control" placeholder="@lang('Method Name')" name="name" value="{{ old('name') }}"/>
                                    </div>
                                    <div class="row mt-4">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="w-100">@lang('Default Currency') <span class="text-danger">*</span></label>
                                                <select name="accepted_currency" class="form-control" required>
                                                    @foreach($currencies as $curr)
                                                        <option value="{{ $curr->id }}">{{ __($curr->currency_code) }}</option>
                                                    @endforeach
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="w-100">@lang('Currency') <span class="text-danger">*</span></label>
                                                <select name="currencies[]" class="form-control select2-multi-select"  multiple="multiple" required>
                                                    @foreach($currencies as $curr)
                                                        <option value="{{ $curr->id }}">{{ __($curr->currency_code) }}</option>
                                                    @endforeach
                                                </select>
                                            </div>
                                        </div>

                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="w-100">@lang('Enable For') <span class="text-danger">*</span></label>
                                                <select name="user_guards[]" class="form-control select2-multi-select"  multiple="multiple" required>

                                                    <option value="1">@lang('USER')</option>
                                                    <option value="2">@lang('AGENT')</option>
                                                    <option value="3">@lang('MERCHANT')</option>

                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="w-100">Automatically<span class="text-danger">*</span></label>
                                            <select class="form-control select-auto-method" name="type_method">
                                                <option value="0">None</option>
                                                <option value="1">InstaForex</option>
                                                <option value="2">Perfect Money</option>
                                            </select>
                                        </div>


                                    </div>

                                    <div class="instaforex-setting" style="display: none">
                                        <div class="row mb-4">
                                            <div class="col-md-6">
                                                <label class="w-100">Umbrella Account</label>
                                                <input type="text" name="setting[umbrella_account]" class="form-control border-radius-5" value="" />
                                            </div>
                                            <div class="col-md-6">
                                                <label class="w-100">Umbrella Password</label>
                                                <input type="text" name="setting[umbrella_password]" class="form-control border-radius-5" value="" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="perfect-money-setting" style="display: none">
                                        <div class="row mb-4">
                                            <div class="col-md-3">
                                                <label class="w-100">Account ID</label>
                                                <input type="text" name="setting[perfect_account_id]" class="form-control border-radius-5" value="" />
                                            </div>
                                            <div class="col-md-3">
                                                <label class="w-100">PM Wallet</label>
                                                <input type="text" name="setting[perfect_wallet]" class="form-control border-radius-5" value="" />
                                            </div>
                                            <div class="col-md-3">
                                                <label class="w-100">Passphrase</label>
                                                <input type="text" name="setting[perfect_passphrase]" class="form-control border-radius-5" value="" />
                                            </div>
                                            <div class="col-md-3">
                                                <label class="w-100">Alternate Passphrase</label>
                                                <input type="text" name="setting[perfect_alternate_passphrase]" class="form-control border-radius-5" value="" />
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="payment-method-body">
                                <div class="row">
                                    <div class="col-lg-6">
                                        <div class="card border--primary mb-2">
                                            <h5 class="card-header bg--primary">@lang('Range')</h5>
                                            <div class="card-body">
                                                <div class="input-group has_append mb-3">
                                                    <label class="w-100">@lang('Minimum Amount') <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" name="min_limit" placeholder="0" value="{{ old('min_limit') }}"/>
                                                    <div class="input-group-append">
                                                        <div class="input-group-text"> {{ __($general->cur_text) }} </div>
                                                    </div>
                                                </div>
                                                <div class="input-group has_append">
                                                    <label class="w-100">@lang('Maximum Amount') <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" placeholder="0" name="max_limit" value="{{ old('max_limit') }}"/>
                                                    <div class="input-group-append">
                                                        <div class="input-group-text"> {{ __($general->cur_text) }} </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-6">
                                        <div class="card border--primary">
                                            <h5 class="card-header bg--primary">@lang('Charge')</h5>
                                            <div class="card-body">
                                                <div class="input-group has_append mb-3">
                                                    <label class="w-100">@lang('Fixed Charge') <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" placeholder="0" name="fixed_charge" value="{{ old('fixed_charge') }}"/>
                                                    <div class="input-group-append">
                                                        <div class="input-group-text"> {{ __($general->cur_text) }} </div>
                                                    </div>
                                                </div>
                                                <div class="input-group has_append">
                                                    <label class="w-100">@lang('Percent Charge') <span class="text-danger">*</span></label>
                                                    <input type="text" class="form-control" placeholder="0" name="percent_charge" value="{{ old('percent_charge') }}">
                                                    <div class="input-group-append">
                                                        <div class="input-group-text">%</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-lg-12">
                                        <div class="card border--dark my-2">

                                            <h5 class="card-header bg--dark">@lang('Withdraw Instruction') </h5>
                                            <div class="card-body">
                                                <div class="form-group">
                                                    <textarea rows="5" class="form-control border-radius-5 nicEdit" name="instruction">{{ old('instruction') }}</textarea>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-lg-12">
                                        <div class="card border--dark">
                                            <h5 class="card-header bg--dark">@lang('User data')
                                                <button type="button" class="btn btn-sm btn-outline-light float-right addUserData">
                                                    <i class="la la-fw la-plus"></i>@lang('Add New')
                                                </button>
                                            </h5>

                                            <div class="card-body">
                                                <div class="row addedField">

                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card-footer">
                        <button type="submit" class="btn btn--primary btn-block">@lang('Save Method')</button>
                    </div>
                </form>
            </div><!-- card end -->
        </div>
    </div>

@endsection


@push('breadcrumb-plugins')
    <a href="{{ route('admin.withdraw.method.index') }}" class="btn btn-sm btn--primary box--shadow1 text--small">
        <i class="la la-fw la-backward"></i> @lang('Go Back')
    </a>
@endpush

@push('script')
    <script>
        (function ($) {
            "use strict";
            $('input[name=currency]').on('input', function () {
                $('.currency_symbol').text($(this).val());
            });
            $('.select-auto-method').on('change', function(){
                var automethod = $(this).val();
                $('.instaforex-setting').hide();
                $('.perfect-money-setting').hide();
                if(automethod === '1'){
                    $('.instaforex-setting').show();
                }
                if(automethod === '2'){
                    $('.perfect-money-setting').show();
                }
            });
            $('.addUserData').on('click', function () {
                var html = `
                    <div class="col-md-12 user-data">
                        <div class="form-group">
                            <div class="input-group mb-md-0 mb-4">
                                <div class="col-md-4">
                                    <input name="field_name[]" class="form-control" type="text" required placeholder="@lang('Field Name')">
                                </div>
                                <div class="col-md-3 mt-md-0 mt-2">
                                    <select name="type[]" class="form-control">
                                        <option value="text" > @lang('Input Text') </option>
                                        <option value="textarea" > @lang('Textarea') </option>
                                        <option value="file"> @lang('File') </option>
                                    </select>
                                </div>
                                <div class="col-md-3 mt-md-0 mt-2">
                                    <select name="validation[]"
                                            class="form-control">
                                        <option value="required"> @lang('Required') </option>
                                        <option value="nullable">  @lang('Optional') </option>
                                    </select>
                                </div>
                                <div class="col-md-2 mt-md-0 mt-2 text-right">
                                    <span class="input-group-btn">
                                        <button class="btn btn--danger btn-lg removeBtn w-100" type="button">
                                            <i class="fa fa-times"></i>
                                        </button>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>`;

                $('.addedField').append(html);
            });

            $(document).on('click', '.removeBtn', function () {
                $(this).closest('.user-data').remove();
            });
            @if(old('currency'))
            $('input[name=currency]').trigger('input');
            @endif
        })(jQuery);

    </script>
@endpush
