<?php

namespace App\Http\Controllers\AppTemplate\Modules;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App \ {
	Categories,
	Posts,
	TagsGroupTags,
	TagsGroups,
	PostTags,
	UserProfiles,
	OutgoingEmailServer
};
use Illuminate\Support\Facades\Auth;
use DB;

class SettingsController extends Controller
{
	protected $postData;


	/* Categories methods  */

	public function getCategories()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {

			$categories = Categories::all();
			foreach ($categories as $key => $value) {
				$value['options'] =
					[
						"editable" => false,
						"hasDependecies" => $this->categoryDependencies($value) > 0 ? true : false
					];
			}
			$response = ["type" => 1, "message" => "OK", "categories" => $categories];
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function saveCategories()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			$this->postData['createdBy'] = Auth::user()->userId;
			if (Categories::create(
				$this->postData
			)) {
				$response = ["type" => 1, "message" => "OK"];
			}
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function updateCategories()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			if (Categories::findOrFail($this->postData['categoryId'])->update(
				$this->postData
			)) {
				$response = ["type" => 1, "message" => "OK"];
			}
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function deleteCategories()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			if (Categories::findOrFail($this->postData['categoryId'])->delete()) {
				$response = ["type" => 1, "message" => "OK"];
			}
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function categoryDependencies($category)
	{
		$dependencies = Posts::where("postCategoryId", $category['categoryId'])->get()->count();
		return $dependencies;
	}

	/* Tags methods */

	public function getTagsGroups()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			$tagsGroups = TagsGroups::all();
			foreach ($tagsGroups as $key => $value) {
				$value['options'] = ["editable" => false];
			}
			$response = ["type" => 1, "message" => "OK", "tagsGroups" => $tagsGroups];
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function getGroupTags()
	{
		// dd('w');
		$response = ["type" => 2, "message" => "failed"];
		try {
			$tagsGroupTags = TagsGroupTags::where("tagGroupId", $this->postData['tagGroupId'])->get();
			foreach ($tagsGroupTags as $key => $value) {
				$value['options'] = [
					"editable" => false,
					"checked" => false,
					"hasDependecies" => $this->getTagDepedendencies($value) > 0 ? true : false
				];
			}
			$response = ["type" => 1, "message" => "OK", "tagsGroupTags" => $tagsGroupTags];
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function getTagDepedendencies($tag)
	{
		$dependencies = PostTags::where(
			[
				"tagId" => $tag['tagId'],
			]
		)->get()->count();
		return $dependencies;
	}


	public function updateGroup()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			if (TagsGroups::findOrFail($this->postData['tagGroupId'])->update(
				["tagGroupName" => $this->postData['tagGroupName']]
			)) {
				$response = ["type" => 1, "message" => "OK"];
			}
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function saveTags()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			$response = $this->saveMultipleTags($this->postData);
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function saveMultipleTags($tagsPendingToBeSaved)
	{
		DB::transaction(function () use ($tagsPendingToBeSaved) {
			foreach ($tagsPendingToBeSaved as $key => $value) {
				$value['createdBy'] = Auth::user()->userId;
				TagsGroupTags::create(
					$value
				);
			}
		});
		return ["type" => 1, "message" => "OK"];
	}

	public function updateTag()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			if (TagsGroupTags::findOrFail($this->postData['tagId'])->update(
				["tagName" => $this->postData['tagName']]
			)) {
				$response = ["type" => 1, "message" => "OK"];
			}
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function deleteTags()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			$response = $this->deleteMultipleTags($this->postData);
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function deleteMultipleTags($tags)
	{
		DB::transaction(function () use ($tags) {
			foreach ($tags as $key => $tag) {
				TagsGroupTags::findOrFail($tag['tagId'])->delete();
			}
		});
		return ["type" => 1, "message" => "OK"];
	}

	/* UserTypes methods */

	public function getUserProfiles()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			$userProfiles = UserProfiles::all();
			foreach ($userProfiles as $key => $value) {
				$value['options'] = ["editable" => false];
			}
			$response = ["type" => 1, "message" => "OK", "userProfiles" => $userProfiles];
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function updateUserProfiles()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			$response = $this->massUpdateUserProfiles($this->postData);
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function massUpdateUserProfiles($userProfiles)
	{
		DB::transaction(function () use ($userProfiles) {
			foreach ($userProfiles as $key => $userProfile) {
				UserProfiles::findOrFail($userProfile['profileId'])->update(["profileName" => $userProfile['profileName'], "updatedBy" => Auth::user()->userId]);
			}
		});
		return ["type" => 1, "message" => "OK"];
	}

	/* OutgoingEmailServer methods */

	public function getData()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			$data = OutgoingEmailServer::first();
			$data->allowCustomSTMP = $data->allowCustomSTMP == 1 ? true : false;
			$response = ["type" => 1, "message" => "OK", "data" => $data];
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function updateData()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			if (OutgoingEmailServer::findOrFail(1)->update(
				$this->postData
			)) {
				$response = ["type" => 1, "message" => "OK"];
			}
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}
}
 