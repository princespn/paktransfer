<?php

namespace App\Http\Controllers\Merchant\Auth;

use App\Models\Wallet;
use App\Models\Currency;
use App\Models\Merchant;
use App\Models\UserLogin;
use Illuminate\Http\Request;
use App\Models\GeneralSetting;
use App\Models\AdminNotification;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Auth\Events\Registered;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rules\Password;
use Illuminate\Foundation\Auth\RegistersUsers;

class RegisterController extends Controller
{
    /*
    |--------------------------------------------------------------------------
    | Register Controller
    |--------------------------------------------------------------------------
    |
    | This controller handles the registration of new users as well as their
    | validation and creation. By default this controller uses a trait to
    | provide this functionality without requiring any additional code.
    |
    */

    // use RegistersUsers;

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('merchant.guest');
        $this->middleware('regStatus')->except('registrationNotAllowed');

        $this->activeTemplate = activeTemplate();
    }

    public function showRegistrationForm()
    {
        $pageTitle = "Merchant Sign Up";
        $info = json_decode(json_encode(getIpInfo()), true);
        $mobile_code = @implode(',', $info['code']);
        $countries = json_decode(file_get_contents(resource_path('views/partials/country.json')));
        return view($this->activeTemplate . 'merchant.auth.register', compact('pageTitle','mobile_code','countries'));
    }

    protected function guard()
    {
        return auth()->guard('merchant');
    }

    /**
     * Get a validator for an incoming registration request.
     *
     * @param  array $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    protected function validator(array $data)
    {
        $general = GeneralSetting::first();
        $password_validation = Password::min(6);
        if ($general->secure_password) {
            $password_validation = $password_validation->mixedCase()->numbers()->symbols()->uncompromised();
        }
        $agree = 'nullable';
        if ($general->agree) {
            $agree = 'required';
        }
        $countryData = (array)json_decode(file_get_contents(resource_path('views/partials/country.json')));
        $countryCodes = implode(',', array_keys($countryData));
        $mobileCodes = implode(',',array_column($countryData, 'dial_code'));
        $countries = implode(',',array_column($countryData, 'country'));
        $validate = Validator::make($data, [
            'firstname' => 'sometimes|required|string|max:50',
            'lastname' => 'sometimes|required|string|max:50',
            'email' => 'required|string|email|max:90|unique:merchants',
            'mobile' => 'required|string|max:50|unique:merchants',
            'password' => ['required','confirmed',$password_validation],
            'username' => 'required|alpha_num|unique:merchants|min:6',
            'captcha' => 'sometimes|required',
            'mobile_code' => 'required|in:'.$mobileCodes,
            'country_code' => 'required|in:'.$countryCodes,
            'country' => 'required|in:'.$countries,
            'agree' => $agree
        ]);
        return $validate;
    }

    public function register(Request $request)
    {
        $this->validator($request->all())->validate();
        $exist = Merchant::where('mobile',$request->mobile_code.$request->mobile)->first();
        if ($exist) {
            $notify[] = ['error', 'The mobile number already exists'];
            return back()->withNotify($notify)->withInput();
        }

        if (isset($request->captcha)) {
            if (!captchaVerify($request->captcha, $request->captcha_secret)) {
                $notify[] = ['error', "Invalid captcha"];
                return back()->withNotify($notify)->withInput();
            }
        }

        event(new Registered($user = $this->create($request->all())));

        $this->guard()->login($user);

        return $this->registered($request, $user)
            ?: redirect($this->redirectPath());
    }



    /**
     * Create a new user instance after a valid registration.
     *
     * @param  array $data
     * @return \App\User
     */
    protected function create(array $data)
    {

        $general = GeneralSetting::first();


        $referBy = session()->get('reference');
        if ($referBy) {
            $referUser = Merchant::where('username', $referBy)->first();
        } else {
            $referUser = null;
        }
        //User Create
       $merchant = new Merchant();
       $merchant->firstname = isset($data['firstname']) ? $data['firstname'] : null;
       $merchant->lastname = isset($data['lastname']) ? $data['lastname'] : null;
       $merchant->email = strtolower(trim($data['email']));
       $merchant->password = Hash::make($data['password']);
       $merchant->username = trim($data['username']);
       $merchant->ref_by = $referUser ? $referUser->id : 0;
       $merchant->country_code = $data['country_code'];
       $merchant->mobile = $data['mobile_code'].$data['mobile'];
       $merchant->address = [
            'address' => '',
            'state' => '',
            'zip' => '',
            'country' => isset($data['country']) ? $data['country'] : null,
            'city' => ''
        ];
       $merchant->status = 1;
       $merchant->ev = $general->ev ? 0 : 1;
       $merchant->sv = $general->sv ? 0 : 1;
       $merchant->ts = 0;
       $merchant->tv = 1;
       $merchant->save();


        $adminNotification = new AdminNotification();
        $adminNotification->user_type = 'MERCHANT';
        $adminNotification->user_id = $merchant->id;
        $adminNotification->title = 'New merchant registered';
        $adminNotification->click_url = urlPath('admin.merchant.detail',$merchant->id);
        $adminNotification->save();


        //Login Log Create
        $ip = $_SERVER["REMOTE_ADDR"];
        $exist = UserLogin::where('user_ip',$ip)->first();
        $userLogin = new UserLogin();

        //Check exist or not
        if ($exist) {
            $userLogin->longitude =  $exist->longitude;
            $userLogin->latitude =  $exist->latitude;
            $userLogin->city =  $exist->city;
            $userLogin->country_code = $exist->country_code;
            $userLogin->country =  $exist->country;
        }else{
            $info = json_decode(json_encode(getIpInfo()), true);
            $userLogin->longitude =  @implode(',',$info['long']);
            $userLogin->latitude =  @implode(',',$info['lat']);
            $userLogin->city =  @implode(',',$info['city']);
            $userLogin->country_code = @implode(',',$info['code']);
            $userLogin->country =  @implode(',', $info['country']);
        }

        $userAgent = osBrowser();
        $userLogin->merchant_id = $merchant->id;
        $userLogin->user_ip =  $ip;
        
        $userLogin->browser = @$userAgent['browser'];
        $userLogin->os = @$userAgent['os_platform'];
        $userLogin->save();


        return $merchant;
    }

    public function checkUser(Request $request){
        $exist['data'] = null;
        $exist['type'] = null;
        if ($request->email) {
            $exist['data'] = Merchant::where('email',$request->email)->first();
            $exist['type'] = 'email';
        }
        if ($request->mobile) {
            $exist['data'] = Merchant::where('mobile',$request->mobile)->first();
            $exist['type'] = 'mobile';
        }
        if ($request->username) {
            $exist['data'] = Merchant::where('username',$request->username)->first();
            $exist['type'] = 'username';
        }
        return response($exist);
    }

    public function registered()
    {
        $currencies = Currency::get(['id','currency_code']);
        if(!$currencies->isEmpty()){
            foreach($currencies as $currency){
                $wallet = new Wallet();
                $wallet->user_id = merchant()->id;
                $wallet->user_type = 'MERCHANT';
                $wallet->currency_id = $currency->id;
                $wallet->currency_code = $currency->currency_code;
                $wallet->save();
            }
        }
        return redirect()->route('merchant.home');
    }

}
