@extends(activeTemplate().'layouts.master')



@section('content')


    @if(!$user->status)


        <!--Hero Area-->
        <section class="hero-section">
            <div class="hero-area wave-animation">
                <div class="single-hero gradient-overlay">
                    <div id="particles-js"></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-xl-8 centered">
                                <div class="hero-sub">
                                    <div class="table-cell">
                                        <div class="hero-left">
                                            <h2>@lang($page_title)</h2>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section><!--/Hero Area-->


    @elseif(!$user->ev)

        <!--Hero Area-->
        <section class="hero-section">
            <div class="hero-area wave-animation">
                <div class="single-hero gradient-overlay">
                    <div id="particles-js"></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-xl-6 centered">
                                <div class="hero-sub">
                                    <div class="table-cell">
                                        <div class="hero-left">
                                            <h2>@lang($page_title)</h2>
                                            <div class="account-form">
                                                <form method="POST" action="{{route('user.verify_email')}}" class="row">
                                                    @csrf
                                                    <div class="col-xl-12">
                                                        <input type="email" name="email"  readonly value="{{auth()->user()->email}}">
                                                    </div>
                                                    <div class="col-xl-12">
                                                        <input  name="email_verified_code"  placeholder="@lang('Code')" class="form-control">
                                                    </div>

                                                    <button type="submit" class="bttn-mid btn-fill w-100">@lang('Submit')</button>
                                                </form>
                                                <div class="extra-links">
                                                    <p class="text-white text-left">@lang('Please check including your Junk/Spam Folder. if not found, you can') <a  href="{{route('user.send_verify_code')}}?type=email"> @lang('Resend code again')</a></p>
                                                    @if ($errors->has('resend'))
                                                        <p class="text-danger">{{ $errors->first('resend') }}</p>
                                                    @endif

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
        </section><!--/Hero Area-->



    @elseif(!$user->sv)
        <!--Hero Area-->
        <section class="hero-section">
            <div class="hero-area wave-animation">
                <div class="single-hero gradient-overlay">
                    <div id="particles-js"></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-xl-8 centered">
                                <div class="hero-sub">
                                    <div class="table-cell">
                                        <div class="hero-left">
                                            <h2>@lang($page_title)</h2>
                                            <div class="account-form">
                                                <form method="POST" action="{{route('user.verify_sms')}}" class="row">
                                                    @csrf
                                                    <div class="col-xl-12">
                                                        <input type="text" name="mobile"  readonly value="{{auth()->user()->mobile}}">
                                                    </div>
                                                    <div class="col-xl-12">
                                                        <input  name="sms_verified_code" placeholder="@lang('Code')">
                                                    </div>

                                                    <button type="submit" class="bttn-mid btn-fill w-100">@lang('Submit')</button>
                                                </form>
                                                <div class="extra-links">
                                                    <p class="text-white text-left">@lang('No code on your phone Yet ?') <a  href="{{route('user.send_verify_code')}}?type=phone"> @lang('Resend code Again')</a></p>
                                                    @if ($errors->has('resend'))
                                                        <p class="text-danger">{{ $errors->first('resend') }}</p>
                                                    @endif

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
        </section><!--/Hero Area-->
    @elseif(!$user->tv)
        <!--Hero Area-->
        <section class="hero-section">
            <div class="hero-area wave-animation">
                <div class="single-hero gradient-overlay">
                    <div id="particles-js"></div>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-xl-8 centered">
                                <div class="hero-sub">
                                    <div class="table-cell">
                                        <div class="hero-left">
                                            <h2>@lang($page_title)</h2>
                                            <div class="account-form">
                                                <form method="POST" action="{{route('user.go2fa.verify')}}" class="row">
                                                    @csrf
                                                    <div class="col-xl-12">
                                                        <p class="text-white">{{\Carbon\Carbon::now()}}</p>
                                                    </div>
                                                    <div class="col-xl-12">
                                                        <label for="InputName">@lang("Google Authenticator Code")  </label>
                                                        <input type="text" name="code" placeholder="@lang('Enter Google Authenticator Code')" required>
                                                    </div>

                                                    <button type="submit" class="bttn-mid btn-fill w-100">@lang('Submit')</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section><!--/Hero Area-->
    @endif
@endsection

