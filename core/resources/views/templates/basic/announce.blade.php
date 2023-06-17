@extends(activeTemplate().'layouts.master')
@section('title','| Announcement')
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



    <section class="blog-area section-padding-2">
        <div class="container">

            <div class="row justify-content-center">

                @foreach($blogs as $k=> $data)
                <div class="col-xl-4 col-lg-4 col-md-6 col-sm-6 wow fadeInUp" data-wow-delay="0.4s">
                    <div class="single-blog-2">
                        <div class="single-blog-img">
                            <img src="{{get_image(config('constants.frontend.blog.post.path').'/'.$data->data_values->image)}}" alt="{{$data->data_values->title}}">
                            <a href="{{route('home.announce.details',[$data->id, str_slug($data->data_values->title)])}}"><i class="fas fa-expand"></i></a>
                        </div>
                        <div class="single-blog-content">
                            <div class="blog-meta">
                                <span><a href=""><i class="far fa-calendar-alt"></i>{{date('d M Y', strtotime($data->created_at))}}</a></span>
                            </div>
                            <h3><a href="{{route('home.announce.details',[$data->id, str_slug($data->data_values->title)])}}">{{__($data->data_values->title)}}</a></h3>
                        </div>
                    </div>
                </div>
                @endforeach



            </div>

            <div class="row">
                <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                    {{$blogs->links('partials.pagination')}}
                </div>
            </div>
        </div>
    </section>
@endsection
