<?php

namespace App\Http\Controllers;

use App\Currency;
use App\Frontend;
use App\Gateway;
use App\GeneralSetting;
use App\Language;
use App\Subscriber;
use Illuminate\Http\Request;

class FrontendController extends Controller
{
    public function index(){


        $data['page_title'] =  "Home";


        $data['homeContent'] = Frontend::where('data_keys', 'homecontent')->latest()->first();

        $data['blogs'] = Frontend::where('data_keys','blog.post')->latest()->limit(3)->get();
        $data['whychoose_caption'] = Frontend::where('data_keys', 'whychoose.caption')->latest()->firstOrFail();
        $data['whychooses'] = Frontend::where('data_keys', 'whychoose')->get();
        $data['flowstep_caption'] = Frontend::where('data_keys', 'flowstep.caption')->latest()->firstOrFail();
        $data['flowsteps'] = Frontend::where('data_keys', 'flowstep')->get();
        $data['howitwork_caption'] = Frontend::where('data_keys', 'howitwork.caption')->latest()->firstOrFail();
        $data['howitworks'] = Frontend::where('data_keys', 'howitwork')->get();
        $data['testimonial_caption'] = Frontend::where('data_keys', 'testimonial.caption')->latest()->firstOrFail();
        $data['testimonials'] = Frontend::where('data_keys', 'testimonial')->latest()->get();
        $data['weAccept'] = Gateway::where('status', 1)->get();
        $data['about'] = Frontend::where('data_keys', 'about')->firstOrFail();
        $data['team_caption'] = Frontend::where('data_keys', 'team.caption')->latest()->firstOrFail();
        $data['teams'] = Frontend::where('data_keys', 'team')->latest()->get();
        $data['faqs'] = Frontend::where('data_keys','faq')->get();

        $data['i'] = 0;

        return view(activeTemplate().'home',$data);
    }

    public function about()
    {
        $data['page_title'] =  "About Us";


        $data['testimonial_caption'] = Frontend::where('data_keys', 'testimonial.caption')->latest()->firstOrFail();
        $data['testimonials'] = Frontend::where('data_keys', 'testimonial')->latest()->get();

        $data['team_caption'] = Frontend::where('data_keys', 'team.caption')->latest()->firstOrFail();
        $data['teams'] = Frontend::where('data_keys', 'team')->latest()->get();
        return view(activeTemplate().'about',$data);
    }


    public function announce()
    {
        $blogs = Frontend::where('data_keys','blog.post')->latest()->paginate(9);
        $page_title = "Announcement";
        return view(activeTemplate().'announce', compact('blogs','page_title'));
    }
    public function announceDetails($id, $slug = null, $key = 'blog.post')
    {
         $post = Frontend::where('id',$id)->where('data_keys',$key)->firstOrFail();
        $page_title = "Announcement";

        $data['title'] = $post->data_values->title;
        $data['details'] = $post->data_values->body;
        $data['image'] = config('constants.frontend.blog.post.path').'/'.$post->data_values->image;
        $blogs = Frontend::where('data_keys','blog.post')->where('id','!=',$post->id)->latest()->limit(5)->get();


        return view(activeTemplate().'announce-details', compact('blogs','post','data','page_title'));
    }

    public function menu($id, $slug = null)
    {
        $menu = Frontend::where('id',$id)->where('data_keys','menu')->firstOrFail();
        $page_title = $menu->data_values->title;
        return view(activeTemplate().'menu',  compact('menu','page_title'));
    }



    public function contact()
    {
        $data['page_title'] =  "Contact Us";
        $data['contact'] =  Frontend::where('data_keys','contact')->firstOrFail();
        return view(activeTemplate().'contact',$data);
    }
    public function contactSubmit(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'phone' => 'required',
            'email' => 'required|string|email',
            'message' => 'required',
            'subject' => 'required'
        ]);

        $subject = $request->subject;
        $txt = "<br><br>" .$request->message;
        $txt .= "<br><br>" . "Contact Number : " . $request->phone . "<br>";

        send_contact($request->email, $request->name, $subject, $txt);

        $notify[] = ['success', 'Contact Message Send'];
        return back()->withNotify($notify);
    }

    public function policyInfo($id, $slug = null)
    {
        $menu = Frontend::where('data_keys','company_policy')->where('id',$id)->firstOrFail();
        $page_title = $menu->data_values->title;
        return view(activeTemplate().'policy', compact('menu','page_title'));
    }

    public function changeLang($lang)
    {

        $language = Language::where('code', $lang)->first();
        if (!$language) $lang = 'en';
        session()->put('lang', $lang);
        return back();
    }

    public function subscribe(Request $request)
    {
        $request->validate([
            'email' => 'required|email|max:255',
        ]);

        $macCount = Subscriber::where('email', trim(strtolower($request->email)))->count();
        if ($macCount > 0) {
            $notify[] = ['error', 'This Email Already Exist !!'];
            return redirect()->to(url()->previous()."#subscribe")->withNotify($notify)->withInput();

        } else {
            Subscriber::create($request->only('email'));
            $notify[] = ['success', 'Subscribe Successfully!'];
            return redirect()->to(url()->previous()."#subscribe")->withNotify($notify);

        }
    }


    // currency layer
    public function cronRate()
    {
        $gnl = GeneralSetting::first();
        $endpoint = 'live';
        $access_key = $gnl->currency_api_key;

        $baseCurrency = $gnl->cur_text;

        $ch = curl_init('http://apilayer.net/api/' . $endpoint . '?access_key=' . $access_key . '&source='.$baseCurrency);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $json = curl_exec($ch);
        curl_close($ch);

        $exchangeRates = json_decode($json);

        foreach ($exchangeRates->quotes as $key => $rate) {
            $curcode = substr($key, -3);
            $currencyCount = Currency::where('code', $curcode)->count();
            if ($currencyCount != 0) {
                $currency = Currency::where('code', $curcode)->first();
                $currency->rate = $rate;
                $currency->update();
            }
        }
    }

    public function merchantRegister()
    {
        $data['page_title'] = "Merchant Account";
        return view(activeTemplate() . 'user.auth.merchant-register', $data);
    }
    public function documentation()
    {
        $data['page_title'] = "Api Documentation";
        $data['currency'] = Currency::where('status',1)->orderBy('code')->get();
        return view(activeTemplate() . 'documentation', $data);
    }


}
