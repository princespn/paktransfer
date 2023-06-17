
<div class="row mb-4">
    <div class="col-md-12">
        <div class="invoice-box table-responsive">
            <table class="cmn-table" cellpadding="0" cellspacing="0">
                <tbody>
                <tr class="top">
                    <td colspan="12">
                        <table class="cmn-table">
                            <tbody>
                            <tr>
                                <td colspan="12">
                                    <a href="{{route('getInvoice.pdf',$invoice->trx )}}" class="btn btn-success float-right"><i class="fa fa-download"></i> @lang('Download Invoice')</a>
                                </td>
                            </tr>

                            <tr>
                                <td class="title">
                                    <img src="{{get_image(config('constants.logoIcon.path') .'/logo.png')}}" style="width:100%; max-width:300px;" class="invoice-logo-filter">
                                </td>
                                <td></td>
                                <td>
                                    @lang('TRX') #: {{$invoice->trx}}<br>
                                    @lang('Date'): {{date('d M Y h:i A ',strtotime($invoice->updated_at))}}
                                    <br>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>

                <tr class="information">
                    <td colspan="9">
                        <table class="cmn-table">
                            <tbody>
                            <tr>
                                <td>
                                    <strong>@lang('Sender From')</strong><br>
                                    @lang('Name'): {{$invoice->user->username}}<br>
                                    @lang('Phone'): {{$invoice->user->mobile }}<br>
                                    @lang('E-mail'): {{$invoice->user->email }}
                                </td>

                                <td>
                                    <strong>@lang('Send To')</strong><br>
                                    @lang('Name'): {{$invoice->name }}<br>
                                    @lang('E-mail'): {{$invoice->email }}<br>
                                    @lang('Address'): {{$invoice->address }}
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>




                <tr class="heading">
                    <td colspan="9">@lang('Details')</td>
                    <td>@lang('Amount')</td>
                </tr>

                @foreach($invoice_details as $k => $val)
                    <tr class="item">
                        <td  colspan="9">{{$k}}</td>
                        <td>   {{formatter_money($val)}} {{$invoice->currency->code }}</td>
                    </tr>
                @endforeach


                <tr class="total">
                    <td colspan="9"></td>
                    <td>
                        <b>@lang('Total'): {{formatter_money($invoice->amount)}} {{$invoice->currency->code}}</b>
                    </td>
                </tr>

                </tbody>
            </table>
        </div>
    </div>
</div>
