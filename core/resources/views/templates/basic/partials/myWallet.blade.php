<div class="col-md-3 ">
    <div class="dashboard-content">
        <div class="row text-white">
            @foreach($myWallet as $k=> $data)
                <div class="col-md-12">
                    <a href="{{route('user.currencyTrx',strtolower($data->currency->code))}}" class="text-white">
                    <div class="dashboard-w2 slice border-radius-5">
                        <div class="details">
                            <p class="amount mb-2 font-weight-bold">{{__($data->currency->name)}}</p>
                            <h6 class="mb-3">  {{formatter_money($data->amount)}} {{__($data->currency->code)}}</h6>
                        </div>
                        <div class="icon">

                            <img src="{{ get_image(config('constants.logoIcon.path') .'/favicon.png') }}" class="wallet-cls" alt="*">
                        </div>
                    </div>
                    </a>

                </div>
            @endforeach
        </div>
    </div>
</div>
