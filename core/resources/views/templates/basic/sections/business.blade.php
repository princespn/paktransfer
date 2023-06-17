@php
    $content = getContent('business.content',true)->data_values;
    $elements = getContent('business.element',false,'',1);
@endphp

<section class="pt-100 pb-100">
    <div class="container">
      <div class="row justify-content-between align-items-center">
        <div class="col-lg-4">
          <span class="section-subtitle border-left">{{__(@$content->title)}}</span>
          <h2 class="section-title">{{__(@$content->heading)}}</h2>
          <p class="mt-3">{{__(@$content->sub_heading)}}</p>
        </div>
        <div class="col-lg-7 mt-lg-0 mt-5">
          <div class="row">
            @foreach ($elements as $el)
                <div class="col-4 coutomer-item">
                <div class="coutomer-single">
                    <img src="{{getImage('assets/images/frontend/business/'.@$el->data_values->client_logo,'140x60')}}" alt="image">
                </div>
                </div><!-- coutomer-item end -->
            @endforeach
          </div>
        </div>
      </div>
    </div>
   </section>