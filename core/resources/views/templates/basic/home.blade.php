@extends($activeTemplate.'layouts.frontend')

@php
	$banner = getContent('banner.content',true)->data_values;
	$brand = getContent('brands.content',true)->data_values;
	$brandElement = getContent('brands.element',false,'',1);

@endphp

@section('content')
<section class="hero bg_img" style="background-image: url('{{getImage('assets/images/frontend/banner/'.@$banner->background_image,'1920x1280')}}')">
	<div class="container">
		
	  <div class="row justify-content-center">
		<div class="col-lg-7 text-center">
		    
		  <div class="hero__subtitle d-inline wow fadeInUp" data-wow-duration="0.3" data-wow-delay="0.3s">{{__(@$banner->title)}}</div>
		  <h2 class="hero__title wow fadeInUp" data-wow-duration="0.3" data-wow-delay="0.5s">{{__(str_replace('&amp;','&',@$banner->heading))}}</h2>
		  
		  <p class="hero__des mt-3 wow fadeInUp" data-wow-duration="0.3" data-wow-delay="0.7s">{{__(@$banner->sub_heading)}}</p>
		  <div class="btn--group justify-content-center mt-4 wow fadeInUp" data-wow-duration="0.3" data-wow-delay="0.9s">
			<a href="{{url(@$banner->button_link)}}" class="btn btn--base btn--custom">{{__(@$banner->button_name)}}</a>
			<a href="{{@$banner->video_link}}" data-rel="lightcase:myCollection" class="video-btn">
			  <span class="icon"><i class="las la-play"></i></span>
			  <span class="text-white">{{@__($banner->video_button_name)}}</span>
			</a>
		  </div>
		</div>
	  </div>
	</div>
  </section>
  <!-- hero section end -->

    @if($sections->secs != null)
    <br>
    <center>><a href="https://instaforex.org/no_deposit_bonus?x=LTRC" target="_blank" style="outline: none"><img src="https://banners.instaforex.org/i/img/banners/en/ndb_500_930x180_en.jpg" width="930" height="180" alt="InstaForex" border="0" /></a></center>
    
        @foreach(json_decode($sections->secs) as $sec)
            @include($activeTemplate.'sections.'.$sec)
        @endforeach
    @endif
@endsection
