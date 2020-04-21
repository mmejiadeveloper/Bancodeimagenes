<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
use Hash;
use App\Http\Middleware\CheckLogged;

class HomeController extends Controller
{
	protected $loggedUser;

	public function index()
	{
		$this->loggedUser = Auth::user();
		$this->loggedUser['encodedPassowrd'] = [
			"mask" => $this->loggedUser['passwordMask'],
			"password" => $this->loggedUser['password'],
		];
		$this->validateUserPasswordIntegrity();
		$this->checkUserAvatarPhotoExistence();
		$loggedUser = $this->loggedUser; //only for the compact
		// dd(Auth::user());
		return view('root.dashboard', compact("loggedUser"));
	}

	public function validateUserPasswordIntegrity()
	{
		$this->loggedUser['userIntegrity'] = Hash::check($this->loggedUser['passwordMask'], $this->loggedUser['password']) ? 1 : 2;
	}
	public function checkUserAvatarPhotoExistence()
	{
		$this->loggedUser['photoProfileExistence'] = \Storage::disk("endUserFiles")->exists('usersAvatar/' . $this->loggedUser['userAvatarFileName']);
	}
}
