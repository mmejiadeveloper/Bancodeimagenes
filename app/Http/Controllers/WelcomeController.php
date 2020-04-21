<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class WelcomeController extends Controller
{
    //
    public function index()
    {
        $url = 'https://s3.' . env('AWS_DEFAULT_REGION') . '.amazonaws.com/' . env('AWS_BUCKET') . '/';
        // dd($url);
        $images = [];

        $files = Storage::disk('s3')->files('');
        foreach ($files as $file) {
            $images[] = [
                'name' => str_replace('images/', '', $file),
                'src' => $url . $file
            ];
        }

        return view('welcome');
    }

    public function store(Request $request)
    {
        // dd(env('AWS_DEFAULT_REGION'));
        
        if ($request->hasFile('profile_image')) {
            
            //get filename with extension
            $filenamewithextension = $request->file('profile_image')->getClientOriginalName();
            
            //get filename without extension
            $filename = pathinfo($filenamewithextension, PATHINFO_FILENAME);
            
            //get file extension
            $extension = $request->file('profile_image')->getClientOriginalExtension();
            
            //filename to store
            $filenametostore = $filename . '_' . time() . '.' . $extension;
            
            //Upload File to s3
            Storage::disk('s3')->put($filenametostore, fopen($request->file('profile_image'), 'r+'), 'images');
            dd($filenamewithextension);

            //Store $filenametostore in the database
        }
    }

    public function destroy($image)
    {
        Storage::disk('s3')->delete('images/' . $image);

        return back()->withSuccess('Image was deleted successfully');
    }
}
