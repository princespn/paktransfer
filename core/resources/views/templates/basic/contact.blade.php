@extends(activeTemplate().'layouts.master')
@section('title',"$page_title")
@section('content')



    <!--breadcrumb area-->
    <section class="breadcrumb-area fixed-head gradient-overlay">
    <div id="particles-js"></div>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-xl-8 col-lg-8 col-md-12 col-sm-12 centered">
                    <div class="banner-title">
                        <h2>{{__($page_title)}}</h2>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <!--Content Section-->
    <section class="section-padding">
        <div class="container">

            <div class="row justify-content-center">
                <div class="col-xl-8 col-lg-8 col-md-12 col-sm-12">
                    <div class="section-title centered">
                        <h2>{{__($contact->data_values->title)}}</h2>
                        <p>{{__($contact->data_values->short_details)}}</p>
                    </div>
                </div>
            </div>

            <div class="row">

                                <div class="col-xl-4">
                    <div class="row mt-5 cl-white">
                        <div class="col-md-12 mb-4">
                            <div class="contact-box centered">
                                <p>@php echo  $contact->data_values->contact_details @endphp</p>
                            </div>
                        </div>
                        <div class="col-md-12 mb-3">
                            <div class="contact-box centered">

                                <p>@php echo  $contact->data_values->email_address @endphp</p>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="contact-box centered ">

                                <p>@php echo  $contact->data_values->contact_number @endphp</p>
                            </div>
                        </div>
                    </div>


                </div>

                
                <div class="col-xl-8">
                    <div class="contact-form">
                        <form action="" method="post">
                            @csrf
                            <h4 class="mb-3">{{ __($contact->data_values->form_heading) }}</h4>


                            <div class="row">
                                <div class="col-md-6">
                                    <input type="text" name="name" placeholder="@lang('Your Name')" value="{{old('name')}}" required>
                                </div>
                                <div class="col-md-6">
                                    <input type="text" name="phone" placeholder="@lang('Contact Number')" value="{{old('phone')}}" required>
                                </div>
                                <div class="col-md-12">
                                    <input type="text" name="email" placeholder="@lang('Enter Email Address')" value="{{old('email')}}" required>
                                </div>
                                <div class="col-md-12">
                                    <input type="text" name="subject" placeholder="@lang('Your Subject')" value="{{old('subject')}}" required>
                                </div>
                            </div>


                            <textarea name="message"  rows="6" placeholder="@lang('Write your message')" required>{{old('message')}}</textarea>
                            <button type="submit" class="bttn-mid btn-fill">@lang('Send message')</button>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </section><!--/Content Section-->


@endsection
