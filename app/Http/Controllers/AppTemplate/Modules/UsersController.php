<?php

namespace App\Http\Controllers\AppTemplate\Modules;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Auth;
use Hash;
use DB;
use App \ {
	User,
	UserProfiles,
	UserDepartments,
	UsersProjects
};

use Illuminate\Support\Facades\File;

class UsersController extends Controller
{
	protected $postData;
	protected $profileAvatarPhoto;
	protected $uploadProccess;

	public function updateUserData(Request $request)
	{
		try {
			$response = ["type" => 2, "message" => "failed"];
			// dd($request->file('files'),$this->postData, $_FILES);
			$this->rehashPassword();
			$this->loadProfileAvatarPhoto($request);
			$result = $this->updateUser();
			if ($result["status"] == "OK") {
				$response = ["type" => 1, "message" => "OK", "loggedUser" => $result['data']];
			}
			return $response;
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function rehashPassword()
	{
		$this->postData['passwordMask'] = $this->postData['password'];
		$this->postData['password'] =  Hash::make($this->postData['password']);
	}

	public function loadProfileAvatarPhoto($request)
	{
		$this->validateFileExistenceAndAssignPropierty($request);
		$this->createExpectedDataPropierty();
		$this->loadFileExtension();
		$this->loadFileName();
		$this->bindFileNameToDataRow();
		$this->captureLastUserProfilePhoto();
		$this->uploadProfileAvatarPhoto();
	}

	public function validateFileExistenceAndAssignPropierty($request)
	{
		$this->profileAvatarPhoto = $request->hasFile('files') ?  $request->file('files')[0] : null;
	}

	public function createExpectedDataPropierty()
	{
		if (!empty($this->profileAvatarPhoto)) {
			$this->profileAvatarPhoto->expectedData = [];
		} else {
			$this->uploadProccess = "NOFILE";
		}
		// dd($this->uploadProccess);
	}

	public function loadFileExtension()
	{
		if (!empty($this->profileAvatarPhoto)) {
			$this->validateFileExtensionType(pathinfo($this->profileAvatarPhoto->getClientOriginalName())['extension']);
			$this->profileAvatarPhoto->expectedData['loadedExtension'] =  pathinfo($this->profileAvatarPhoto->getClientOriginalName())['extension'];
		}
	}

	public function loadFileName()
	{
		if (!empty($this->profileAvatarPhoto) && $this->profileAvatarPhoto->expectedData['status'] == 'OK') {
			$this->profileAvatarPhoto->expectedData['fileName'] =  Auth::user()->userId . "_" . date('YmdHis') . "." . $this->profileAvatarPhoto->expectedData['loadedExtension'];
		}
	}

	public function bindFileNameToDataRow()
	{
		if (!empty($this->profileAvatarPhoto)) {
			if (strlen($this->profileAvatarPhoto->expectedData['fileName']) > 0) {
				$this->postData['userAvatarFileName'] = $this->profileAvatarPhoto->expectedData['fileName'];
			}
		} else {
			if ($this->postData['userId'] == 0) {
				$this->postData['userAvatarFileName'] =   'default.jpg';
			}
		}
	}

	public function captureLastUserProfilePhoto()
	{
		if (!empty($this->profileAvatarPhoto) && $this->profileAvatarPhoto->expectedData['status'] == 'OK' && $this->postData['userAvatarFileName'] != 'default') {
			// dd($this->postData);
			if ($this->postData['userId'] != 0) {
				$this->profileAvatarPhoto->expectedData['oldFile'] = User::findOrFail($this->postData['userId'])->userAvatarFileName;
			}
		}
	}

	public function uploadProfileAvatarPhoto()
	{
		if (!empty($this->profileAvatarPhoto) && $this->profileAvatarPhoto->expectedData['status'] == 'OK') {
			if (\Storage::disk("endUserFiles")->put("/usersAvatar/" . $this->profileAvatarPhoto->expectedData['fileName'],  \File::get($this->profileAvatarPhoto))) {
				$this->checkAndRemoveLastProfilePhoto();
			}
		} 
	}

	public function validateFileExtensionType($extension)
	{
		$allowedFileExtensions = ["jpg", "png", "gif"];
		$this->profileAvatarPhoto->expectedData['status'] = in_array($extension, $allowedFileExtensions) ? "OK" : "failed: Extension is not valid";
	}

	public function checkAndRemoveLastProfilePhoto()
	{
		if ($this->postData['userId'] != 0 && $this->profileAvatarPhoto->expectedData['oldFile'] != 'default.jpg') {
			if (\Storage::disk("endUserFiles")->exists('usersAvatar/' . $this->profileAvatarPhoto->expectedData['oldFile'])) {
				\Storage::disk("endUserFiles")->delete('usersAvatar/' . $this->profileAvatarPhoto->expectedData['oldFile']);
				$this->profileAvatarPhoto->expectedData['readyForUpdateData'] = "OK";
				$this->uploadProccess = "OK";
			}
		} else {
			$this->profileAvatarPhoto->expectedData['readyForUpdateData'] = "OK";
			$this->uploadProccess = "OK";
		}
	}

	public function updateUser()
	{
		$response = "";

		if ($this->uploadProccess == 'OK') {
			if ($this->profileAvatarPhoto->expectedData['readyForUpdateData'] == "OK" && $this->profileAvatarPhoto->expectedData['status'] == 'OK') {
				User::findOrFail($this->postData['userId'])->update($this->postData);
				$user = User::findOrFail($this->postData['userId']);
				$user['photoProfileExistence'] = \Storage::disk("endUserFiles")->exists('usersAvatar/' . $user['userAvatarFileName']);
				$response = ["status" => "OK", "data" => $user, "type" => 1];
			} else {
				$response = ["status" => "failed", "type" => 2];
			}
		} else {
			// dd('NO FOTO', $this->postData );
			User::findOrFail($this->postData['userId'])->update($this->postData);
			$user = User::findOrFail($this->postData['userId']);
			$user['photoProfileExistence'] = \Storage::disk("endUserFiles")->exists('usersAvatar/' . $user['userAvatarFileName']);
			$response = ["status" => "OK", "data" => $user, "type" => 1];
		}
		return $response;
	}

	/*** crud users operations ***/
	public function getUsers()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			$users = User::getUsersForModuleList();
			$response = ["type" => 1, "message" => "OK", "users" => $users];
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function updateUserStatus()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			// dd( $this->postData['userState'] == true ? 1 : 0);
			if (User::findOrFail($this->postData['userId'])->update(
				["userState" => $this->postData['userState'] == true ? 1 : 0]
			)) {
				$response = ["type" => 1, "message" => "OK"];
			}
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function createUser(Request $request)
	{
		$response = ["type" => 2, "message" => "failed"];
		try {
			$this->rehashPassword();
			$this->loadProfileAvatarPhoto($request);
			// dd($this->postData);
			if (Auth::user()->userId == 1) {
				if (User::create(
					$this->postData
				)) {
					$response = ["type" => 1, "message" => "OK"];
				}
			}
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function loadProfiles()
	{
		$response = [
			"type" => 1, "message" => "OK", "data" =>
			Auth::user()->userId == 1 ? UserProfiles::all() : UserProfiles::where("profileId", "!=", 1)->get()
		];
		return $response;
	}

	public function loadDepartments()
	{
		$response = [
			"type" => 1, "message" => "OK", "data" => UserDepartments::all()
		];
		return $response;
	}

	public function getDeparmentsAndProfiles()
	{
		$response = ["type" => 2, "message" => "failed"];
		try {

			$response = ["type" => 1, "message" => "OK", "data" => [
				"profiles" => $this->loadProfiles()['data'],
				"departments" => $this->loadDepartments()['data']
			]];
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function getUsersByFilters()
	{
		$response = ['type' => 2, 'message' => 'failed'];
		try {
			$users = User::getUsersForModuleList($this->postData);
			$response = ['type' => 1, 'message' => 'OK', 'data' => $users];
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function getUserDepartments()
	{
		$response = ['type' => 2, 'message' => 'failed'];
		try {
			$response = ['type' => 1, 'message' => 'OK', 'userDepartments' => UserDepartments::all()];
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function getUserProjects()
	{
		$response = ['type' => 2, 'message' => 'failed'];
		try {
			$textInput = $this->postData['inputText'];
			if(strlen($textInput) > 0 ) {
				$projects = UsersProjects::where(["userId" => Auth::user()->userId])->where('projectName', 'like', '%'.$textInput.'%')->get();
			}else{
				$projects = UsersProjects::where(["userId" => Auth::user()->userId])->get();
			}
			$response = ['type' => 1, 'message' => 'OK', 'data' => $projects];
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}
}
