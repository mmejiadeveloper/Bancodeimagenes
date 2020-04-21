<?php

namespace App\Http\Middleware;

use Closure;
use Auth;
use Illuminate\Support\Facades\Route;
class CheckLogged
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        // dd(Auth::user(), $next($request), $request->getPathInfo() );
        // dd(Route::getCurrentRoute()->getActionName(), $request, );
        $response = $next($request);;
        $route = $request->getPathInfo();
        if ($route == '/logout') {
            return response()->view('root.app');
            // return redirect('/');
        }
        
       /*  if ( ! Auth::user()) // Your logic here...
            return view('root.app'); */
        
        return $response;
    }
}
