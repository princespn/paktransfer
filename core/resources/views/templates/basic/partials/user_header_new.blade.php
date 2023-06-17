<div class="d-sidebar h-100 rounded">
    <button class="sidebar-close-btn bg--base text-white"><i class="las la-times"></i></button>
    <a href="#0" class="header-username">{{auth()->user()->fullname}}</a>
    <div class="sidebar-menu-wrapper" id="sidebar-menu-wrapper">
        <ul class="sidebar-menu">
            <li class="sidebar-menu__header">@lang('Main')</li>
            <li class="sidebar-menu__item {{menuActive('user.home')}}">
                <a href="{{route('user.home')}}" class="sidebar-menu__link">
                    <i class="lab la-buffer"></i>
                   @lang(' Dashboard')
                </a>
            </li> 
             @if(module('request_money',$module)->status)
            <li class="sidebar-menu__item {{menuActive('user.transactions')}}">
                <a href="{{route('user.transactions')}}" class="sidebar-menu__link">
                    <i class="las la-file-invoice-dollar"></i>
                   @lang('Transactions')
                </a>
            </li> 
            @endif
            
            @if(module('request_money',$module)->status)
            <li class="sidebar-menu__item {{menuActive('user.verifications')}}">
                <a href="{{url('user/fill-up/kyc')}}" class="sidebar-menu__link">
                    <i class="las la-file-invoice-dollar"></i>
                   @lang('Verifications')
                </a>
            </li> 
            @endif

            @if(module('add_money',$module)->status)
            <li class="sidebar-menu__header">@lang('Deposit')</li>
            <li class="sidebar-menu__item {{menuActive('user.deposit')}}">
                <a href="{{route('user.deposit')}}" class="sidebar-menu__link">
                    <i class="las la-wallet"></i>
                   @lang('Deposit Money')
                </a>
            </li>
            <li class="sidebar-menu__item {{menuActive('user.deposit.history')}}">
                <a href="{{route('user.deposit.history')}}" class="sidebar-menu__link">
                    <i class="las la-history"></i>
                   @lang('Deposit History')
                </a>
            </li>
            @endif

            @if(module('withdraw_money',$module)->status)
            <li class="sidebar-menu__header">@lang('Withdraw')</li>
            <li class="sidebar-menu__item {{menuActive('user.withdraw.money')}}">
                <a href="{{route('user.withdraw.money')}}" class="sidebar-menu__link">
                    <i class="las la-university"></i>
                    @lang('Withdraw Money')
                </a>
            </li>
            <li class="sidebar-menu__item {{menuActive('user.withdraw.history')}}">
                <a href="{{route('user.withdraw.history')}}" class="sidebar-menu__link">
                    <i class="las la-history"></i>
                   @lang('Withdraw History')
                </a>
            @endif  

            @if(module('request_money',$module)->status)
            <li class="sidebar-menu__header">@lang('Exchange Money')</li>
            <li class="sidebar-menu__item {{menuActive('user.exchange.money')}}">
                <a href="{{route('user.exchange.money')}}" class="sidebar-menu__link">
                    <i class="las la-university"></i>
                    @lang('Exchange Money')
                </a>
            </li> 
            @endif

            @if(module('money_out',$module)->status || module('make_payment',$module)->status)

            <li class="sidebar-menu__header">@lang('Send Money')</li>

            @if(module('transfer_money',$module)->status)
            <li class="sidebar-menu__item {{menuActive('user.transfer')}}">
                <a href="{{route('user.transfer')}}" class="sidebar-menu__link">
                    <i class="las la-university"></i>
                    @lang('Sent to user')
                </a>
            </li>             
            @endif
            @if(module('money_out',$module)->status)
            <li class="sidebar-menu__item {{menuActive('user.money.out')}}">
                <a href="{{route('user.money.out')}}" class="sidebar-menu__link">
                    <i class="las la-university"></i>
                    @lang('Sent to agent')
                </a>
            </li>   
            @endif
            @if(module('make_payment',$module)->status) 
            <li class="sidebar-menu__item {{menuActive('user.payment')}}">
                <a href="{{route('user.payment')}}" class="sidebar-menu__link">
                    <i class="las la-university"></i>
                    @lang('Sent to Merchant')
                </a>
            </li>    
            @endif
            @endif


            @if(module('request_money',$module)->status)
            <li class="sidebar-menu__header">@lang('Request Money')</li> 
            <li class="sidebar-menu__item {{menuActive('user.request.money')}}">
                <a href="{{route('user.request.money')}}" class="sidebar-menu__link">
                    <i class="las la-money"></i>
                    @lang('Request Money')
                </a>
            </li>  
            <li class="sidebar-menu__item {{menuActive('user.requests')}}">
                <a href="{{route('user.requests')}}" class="sidebar-menu__link">
                    <i class="las la-money"></i>
                    @lang('Requests to me')
                </a>
            </li>  
            @endif
            @if(module('create_voucher',$module)->status) 
            <li class="sidebar-menu__header">@lang('Voucher')</li>
            <li class="sidebar-menu__item {{menuActive('user.voucher.create')}}">
              <a href="{{route('user.voucher.create')}}" class="sidebar-menu__link">
                  <i class="las la-money"></i>
                  @lang('Create New Voucher')
              </a> 
            </li>
            <li class="sidebar-menu__item {{menuActive('user.voucher.list')}}">
              <a href="{{route('user.voucher.list')}}" class="sidebar-menu__link">
                  <i class="las la-money"></i>
                  @lang('My Vouchers')
              </a> 
            </li> 
            <li class="sidebar-menu__item {{menuActive('user.voucher.redeem')}}">
              <a href="{{route('user.voucher.redeem')}}" class="sidebar-menu__link">
                  <i class="las la-money"></i>
                  @lang('Vouchers Redeem')
              </a> 
            </li>  
            @endif 
        </ul><!-- sidebar-menu end -->
    </div>
</div> 
@push('script')
     <script>
            'use strict';
            (function ($) {
                const sidebar = document.querySelector('.d-sidebar');
                const sidebarOpenBtn = document.querySelector('.sidebar-open-btn');
                const sidebarCloseBtn = document.querySelector('.sidebar-close-btn');

                sidebarOpenBtn.addEventListener('click', function(){
                    sidebar.classList.add('active');
                });
                sidebarCloseBtn.addEventListener('click', function(){
                    sidebar.classList.remove('active');
                });


                $(function(){
                    $('#sidebar-menu-wrapper').slimScroll({
                        // height: 'calc(100vh - 52px)'
                        height: '100vh'
                    });
                });

                $('.sidebar-dropdown > a').on('click', function () {
                    if ($(this).parent().find('.sidebar-submenu').length) {
                        if ($(this).parent().find('.sidebar-submenu').first().is(':visible')) {
                        $(this).find('.side-menu__sub-icon').removeClass('transform rotate-180');
                        $(this).removeClass('side-menu--open');
                        $(this).parent().find('.sidebar-submenu').first().slideUp({
                            done: function done() {
                            $(this).removeClass('sidebar-submenu__open');
                            }
                        });
                        } else {
                        $(this).find('.side-menu__sub-icon').addClass('transform rotate-180');
                        $(this).addClass('side-menu--open');
                        $(this).parent().find('.sidebar-submenu').first().slideDown({
                            done: function done() {
                            $(this).addClass('sidebar-submenu__open');
                            }
                        });
                        }
                    }
                });
            })(jQuery);
     </script>
@endpush