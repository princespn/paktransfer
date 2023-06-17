
<header class="header">
    <div class="header__top">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-lg-3 col-sm-4 text-sm-start text-center d-sm-block d-none">
            <a href="javascript:void(0)" class="header-username">{{auth()->user()->fullname}}</a>
          </div>
          <div class="col-lg-9 col-sm-8">
            <div class="d-flex flex-wrap justify-content-sm-end justify-content-center align-items-center">
              <ul class="header-top-menu">
                <li><a href="{{route('ticket')}}">@lang('Support Ticket')</a></li>
              </ul>
              <div class="header-user">
                <span class="thumb"></span>
                <span class="name">{{auth()->user()->username}}</span>
                <ul class="header-user-menu">
                  <li><a href="{{route('user.profile.setting')}}"><i class="las la-user-circle"></i> @lang('Profile')</a></li>
                  <li><a href="{{route('user.change.password')}}"><i class="las la-cogs"></i>@lang('Change Password')</a></li>
                  <li><a href="{{route('user.twofactor')}}"><i class="las la-bell"></i>@lang('2FA Security')</a></li>
                  <li><a href="{{route('user.qr')}}">  <i class="las la-qrcode"></i>@lang('My QRcode')</a></li>
                  <li><a href="{{route('user.logout')}}"><i class="las la-sign-out-alt"></i>@lang('Logout')</a></li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="sidebar {{ sidebarVariation()['selector'] }} {{ sidebarVariation()['sidebar'] }} {{ @sidebarVariation()['overlay'] }} {{ @sidebarVariation()['opacity'] }}"
     data-background="{{getImage('assets/admin/images/sidebar/2.jpg','400x800')}}" style="background-color:#162447 !important">
    <button class="res-sidebar-close-btn"><i class="las la-times"></i></button>
      <div class="sidebar__inner">
        <div class="sidebar__logo">
           <a href="javascript:void(0)" class="header-username">{{auth()->user()->fullname}}</a>
        </div>
        <div class="sidebar__menu-wrapper" id="sidebar__menuWrapper" style="overflow: hidden;width: auto;height: calc(100vh - 86.75px);">
          <div class="sidebar"
            data-background="{{getImage('assets/admin/images/sidebar/2.jpg','400x800')}}">
            <button class="res-sidebar-close-btn"><i class="las la-times"></i></button>
            <div class="sidebar__inner">
              <div class="sidebar__menu-wrapper" id="sidebar__menuWrapper">
                <ul class="sidebar__menu">
                  <li class="sidebar__menu-header">
                    <a href="{{route('user.home')}}">@lang('Dashboard')</a>
                  </li>
                  @if(module('add_money',$module)->status)
                  <li class="sidebar__menu-header">@lang('Deposit')</li>
                  <li class="sidebar-menu-item">
                    <a href="{{route('user.deposit')}}" class="nav-link ">
                      <i class="menu-icon las la-home"></i>
                      <span class="menu-title">@lang('Deposit Money')</span>
                    </a>
                  </li>
                  <li class="sidebar-menu-item">
                    <a href="{{route('user.deposit.history')}}" class="nav-link ">
                      <i class="menu-icon las la-home"></i>
                      <span class="menu-title">@lang('Deposit History')</span>
                    </a>
                  </li>
                  @endif
                  @if(module('withdraw_money',$module)->status)
                  <li class="sidebar__menu-header">@lang('Withdrawals')</li>
                  <li class="sidebar-menu-item">
                    <a href="{{route('user.withdraw.money')}}" class="nav-link ">
                      <i class="menu-icon las la-home"></i>
                      <span class="menu-title">@lang('Withdraw Money')</span>
                    </a>
                  </li>
                  <li class="sidebar-menu-item">
                    <a href="{{route('user.withdraw.methods')}}" class="nav-link ">
                      <i class="menu-icon las la-home"></i>
                      <span class="menu-title">@lang('Withdraw methods')</span>
                    </a>
                  </li>
                  <li class="sidebar-menu-item">
                    <a href="{{route('user.withdraw.history')}}" class="nav-link ">
                      <i class="menu-icon las la-home"></i>
                      <span class="menu-title">@lang('Withdraw History')</span>
                    </a>
                  </li>
                  @endif
                  @if(module('request_money',$module)->status)
                  <li class="sidebar__menu-header">@lang('Exchange Money')</li>
                  <li class="sidebar-menu-item">
                    <a href="{{route('user.exchange.money')}}" class="nav-link ">
                      <i class="menu-icon las la-home"></i>
                      <span class="menu-title">@lang('Exchange Money')</span>
                    </a>
                  </li>
                  @endif
                  @if(module('money_out',$module)->status || module('make_payment',$module)->status)
                  <li class="sidebar__menu-header">@lang('Send Money')</li>
                  @if(module('transfer_money',$module)->status)
                  <li class="sidebar-menu-item">
                    <a href="{{route('user.transfer')}}" class="nav-link ">
                      <i class="menu-icon las la-home"></i>
                      <span class="menu-title">@lang('Sent to user')</span>
                    </a>
                  </li>
                  @endif
                  @if(module('money_out',$module)->status)
                  <li class="sidebar-menu-item">
                    <a href="{{route('user.money.out')}}" class="nav-link ">
                      <i class="menu-icon las la-home"></i>
                      <span class="menu-title">@lang('Send to agent')</span>
                    </a>
                  </li>
                  @endif
                  @if(module('make_payment',$module)->status)
                  <li class="sidebar-menu-item">
                    <a href="{{route('user.payment')}}" class="nav-link ">
                      <i class="menu-icon las la-home"></i>
                      <span class="menu-title">@lang('Send to Merchant')</span>
                    </a>
                  </li>
                  @endif
                  @endif
                  @if(module('request_money',$module)->status)
                  <li class="sidebar__menu-header">@lang('Request Money')</li>
                  <li class="sidebar-menu-item">
                    <a href="{{route('user.request.money')}}" class="nav-link ">
                      <i class="menu-icon las la-home"></i>
                      <span class="menu-title">@lang('Request Money')</span>
                    </a>
                  </li>
                  <li class="sidebar-menu-item">
                    <a href="{{route('user.requests')}}" class="nav-link ">
                      <i class="menu-icon las la-home"></i>
                      <span class="menu-title">@lang('Requests to me')</span>
                    </a>
                  </li>
                  @endif
                  @if(module('create_voucher',$module)->status)
                  <li class="sidebar__menu-header">@lang('Voucher')</li>
                  <li class="sidebar-menu-item">
                    <a href="{{route('user.voucher.create')}}" class="nav-link ">
                      <i class="menu-icon las la-home"></i>
                      <span class="menu-title">@lang('Create New Voucher')</span>
                    </a>
                  </li>
                  <li class="sidebar-menu-item">
                    <a href="{{route('user.voucher.list')}}" class="nav-link ">
                      <i class="menu-icon las la-home"></i>
                      <span class="menu-title">@lang('My Vouchers')</span>
                    </a>
                  </li>
                  <li class="sidebar-menu-item">
                    <a href="{{route('user.voucher.redeem')}}" class="nav-link ">
                      <i class="menu-icon las la-home"></i>
                      <span class="menu-title">@lang('Voucher Redeem')</span>
                    </a>
                  </li>
                  @endif
                  @if(module('request_money',$module)->status)
                  <li class="sidebar__menu-header">@lang('Transactions')</li>
                  <li class="sidebar-menu-item">
                    <a href="{{route('user.transactions')}}" class="nav-link ">
                      <i class="menu-icon las la-home"></i>
                      <span class="menu-title">@lang('Transactions')</span>
                    </a>
                  </li>
                  @endif
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </header>
