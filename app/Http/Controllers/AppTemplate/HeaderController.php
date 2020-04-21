<?php

namespace App\Http\Controllers\AppTemplate;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Categories;
use App\Users;
use Auth;
use DB;
use App\ViewsRolesPermisions;

class HeaderController extends Controller
{

    public function getCategories()
    {
        try {
            // dd( Auth::user());
            $categories = Auth::user()->profileId == 1 ?  Categories::getCategoriesByGodProfile() : Categories::getCategoriesByNotGodProfile(Auth::user()->idProfile);
            $response = ["data" => $categories,  "type" => 1, "message" => "Data successfully obtained"];
            return $response;
        } catch (\Throwable $th) {
            $response = $this->errorReporting($th);
        }
    }
    public function getViews()
    {
        try {
            $categories =  ViewsRolesPermisions::getViews();
            $response = ["data" => $categories,  "type" => 1, "message" => "Data successfully obtained"];
            return $response;
        } catch (\Throwable $th) {
            $response = $this->errorReporting($th);
        }
    }
}
