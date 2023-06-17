<!-- brand section start -->
<div class="brand-section">
<div class="container">
  <div class="row align-items-center">
	<div class="col-lg-4">
	  <h4>{{__(@$brand->heading)}}</h4>
	</div>
	<div class="col-lg-8">
	  <div class="brand-slider">
		  @foreach ($brandElement as $el)
		  <div class="single-slide">
			<div class="brand-item">
			  <img src="{{asset('assets/images/frontend/brands/'.$el->data_values->brand_logo,'60x32')}}" alt="image">
			</div>
		  </div><!-- single-slide end -->
		  @endforeach
	  </div>
	</div>
  </div>
</div>
</div>
<!-- brand section end -->