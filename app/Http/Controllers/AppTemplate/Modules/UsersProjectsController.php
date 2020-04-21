<?php

namespace App\Http\Controllers\AppTemplate\Modules;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use App\UsersProjects;
use App\PostsUserProjects;
use DB;
use App\PostsFavorites;

class UsersProjectsController extends Controller
{
    protected $postData;

    public function saveProject()
    {
        $response = ['type' => 2, 'message' => 'failed'];
        try {
            $this->postData['userId'] = Auth::user()->userId;
            UsersProjects::create(
                $this->postData
            );
            $response = ['type' => 1, 'message' => 'OK', 'projects' => UsersProjects::where(["userId" => Auth::user()->userId])->get()];
        } catch (\Throwable $th) {
            $response = $this->errorReporting($th);
        }
        return $response;
    }

    public function getUserProjects()
    {
        $response = ['type' => 2, 'message' => 'failed'];
        try {
            // $data = UsersProjects::where(["userId" => Auth::user()->userId])->get();
            $data = UsersProjects::getProjectsWithPosts();
            $response = ['type' => 1, 'message' => 'OK', 'data' => $data];
        } catch (\Throwable $th) {
            $response = $this->errorReporting($th);
        }
        return $response;
    }

    public function getUserDownloads()
    {
        $response = ['type' => 2, 'message' => 'failed'];
        try {
            $data = UsersProjects::getPostsByDownloads();
            $response = ['type' => 1, 'message' => 'OK', 'data' => $data];
        } catch (\Throwable $th) {
            $response = $this->errorReporting($th);
        }
        return $response;
    }

    public function deleteUserProject()
    {
        $response = ['type' => 2, 'message' => 'failed'];
        try {
            if (UsersProjects::where(["usersProjectId" => $this->postData['usersProjectId']])->delete()) {
                $response = ['type' => 1, 'message' => 'OK'];
            }
        } catch (\Throwable $th) {
            $response = $this->errorReporting($th);
        }
        return $response;
    }

    public function filterDownloads()
    {
        $response = ['type' => 2, 'message' => 'failed'];
        try {
            $data = UsersProjects::getPostsByDownloads($this->postData);
            $response = ['type' => 1, 'message' => 'OK', 'data' => $data];
        } catch (\Throwable $th) {
            $response = $this->errorReporting($th);
        }
        return $response;
    }

    public function getUserFavorites()
    {
        $response = ['type' => 2, 'message' => 'failed'];
        try {
            $data = PostsFavorites::getFavoriteUsersPosts();
            $response = ['type' => 1, 'message' => 'OK', 'data' => $data];
        } catch (\Throwable $th) {
            $response = $this->errorReporting($th);
        }
        return $response;
    }

    public function searchByFilters()
    {
        $response = ['type' => 2, 'message' => 'failed'];
        try {
            $data = PostsFavorites::getPostsForModuleList($this->postData);
            $response = ['type' => 1, 'message' => 'OK', 'data' => $data];
        } catch (\Throwable $th) {
            $response = $this->errorReporting($th);
        }
        return $response;
    }
}
