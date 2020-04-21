<?php

namespace App\Http\Controllers\AppTemplate\Modules;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use DB;
use App \ {
	Posts,
	Categories,
	PostTypes,
	User,
	TagsGroups,
	PostFilters,
	PostsFavorites,
	PostsUserProjects
};
use Illuminate\Support\Facades\Auth;

class PostsController extends Controller
{
	protected $postData;

	public function getPosts()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			$posts =  Posts::getPostsForModuleList();
			$response = ["type" => 1, "message" => "OK", "posts" => $posts];
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function getPost()
	{
		$response = ["type" => 2, "message" => "failed"];
		try { 
			$post =  Posts::getPost($this->postData['postId']);
			$similarPosts =  Posts::getPostsForModuleList(0, ["similarPostsFilter"=> [ "postCategoryId" => $post->postCategoryId , "postId" => $post->postId ] ] );
			$response = ["type" => 1, "message" => "OK", "post" => $post, "similarPosts" => $similarPosts];
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function deletePost()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			if (Posts::findOrFail($this->postData['postId'])->delete()) {
				$response = ["type" => 1, "message" => "OK"];
			}
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function updatePostStatus()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			// dd( $this->postData);
			// dd(Posts::findOrFail($this->postData['postId'])->update(["postState"=>$this->postData['postState'] == true ? 1 : 0]));
			if (Posts::findOrFail($this->postData['postId'])->update(
				["postState" => $this->postData['postState'] == true ? 0 : 1]
			)) {
				$response = ["type" => 1, "message" => "OK"];
			}
		} catch (\Throwable $th) {
			if ($this->debugAsyncRequests) {
                dd("error found @ line: " . $th->getLine(), ". Error: ", $th->getMessage());
            } else {
                $response = ["type" => 3, "message" => "Ha ocurrido un fallo en el sistema, si el problema persiste por favor comuniquese con los administradores."];
            }
		}
		return $response;
	}

	public function getSettings()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			$categories =  Auth::user()->userId == 1 ? 
			Categories::orderby('categoryName','asc')->get() : 
			Categories::where('categoryId', "!=", 6)->orderby('categoryName','asc')->get() ; //Solo se muestra la cateogria fondos, de id 6, al administrador
			$types =  PostTypes::all();
			$tags =  TagsGroups::getAllNestedData();
			$users =  Auth::user()->profileId == 1 ? User::where('profileId',2)->orderby('name','asc')->get()  : [];
			$lastIdInserted = Posts::select("postId")->orderBy('postId', 'desc')->first()['postId'] + 1;
			$filters =  PostFilters::getAllNestedData();
			$response = ["type" => 1, "message" => "OK", "data" => ["types" => $types, "categories" => $categories, "users" => $users, "tags" => $tags, "filters" => $filters, "lastIdInserted" => $lastIdInserted]];
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function searchByFilters()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			$posts = Posts::getPostsForModuleList(0, $this->postData);
			$response = ["type" => 1, "message" => "OK", "data" => $posts];
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function searchPosts()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			$posts = Posts::getPostsBySearchText($this->postData);
			$response = ["type" => 1, "message" => "OK", "data" => $posts];
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function setFavoritePost()
	{
		$response = ['type' => 2, 'message' => 'failed'];
		try {
			// $this->postData['postFavoriteId'] = 1;
			if (!PostsFavorites::find($this->postData['postFavoriteId'])) {
				PostsFavorites::create($this->postData);

				$response = ['type' => 1, 'message' => 'Te gusta esta publicaci&oacute;n', "data" => Posts::getPost($this->postData['postId'])];
			} else {
				PostsFavorites::findOrFail($this->postData['postFavoriteId'])->delete();
				$response =  ['type' => 1, 'message' => 'Ya  no te gusta esta publicaci&oacute;n', "data" => Posts::getPost($this->postData['postId'])];
			}
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function saveProjectAndDownload()
	{
		$response = ['type' => 2, 'message' => 'failed'];
		try {
			$this->savePostToProjects();
			$currentDownloads = Posts::findOrFail($this->postData['postId'])->downloads;
			if (Posts::findOrFail($this->postData['postId'])->update(["downloads" => $currentDownloads + 1])) {
				$response = ['type' => 1, 'message' => 'OK'];
			} else {
				$response = ['type' => 2, 'message' => 'failed'];
			}
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function savePostToProjects()
	{
		DB::transaction(function () {
			foreach ($this->postData as $key => $value) {
				if ($key == 'postId') {
					$postId = $value;
				}
				if ($key == "projects") {
					foreach ($value as $skey => $svalue) {
						if ($svalue) {
							$projectId = explode('_', $skey)[1];
							PostsUserProjects::create(
								["postId" => $postId, "projectId" => $projectId]
							);
						}
					}
				}
			}
		});
	}

	
}
