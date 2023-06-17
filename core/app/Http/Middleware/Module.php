<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class Module
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next, $access)
    {
        $permission = module($access);
        if($permission->status == 0){
            abort(404);
        }
        return $next($request);
    }
}
