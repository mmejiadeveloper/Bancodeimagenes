<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\SendsPasswordResetEmails;
use Illuminate\Support\Facades\Mail;
use App\Mail\SendMailable;

use Hash;
use App \ {
    User
};

class ForgotPasswordController extends Controller
{
    use SendsPasswordResetEmails;
    protected $postData;
    protected $foundUserByEmail;
    protected $dataFromUserLogin;
    protected $newHashedPassword;

    public function __construct()
    {
        // $this->middleware('guest');
        $this->postData = isset($_POST['data']) ? $this->axiosDataToAssocArray(json_decode($_POST['data'])) : [];
    }

    public function resetUserPassword()
    {
        $response = ['type' => 2, 'message' => 'failed'];
        try {
            $response = $this->checkUserByExistence();
            if($response['exist']) {
                $this->changePassword();
                $this->sendEmail();
                $response = ['type' => 1, 'message' => 'Hemos enviado una contraseña temporal a tu correo electrónico, recuerda cambiarla.'];
            }
        } catch (\Throwable $th) {
            $response = $this->errorReporting($th);
        }
        return $response;
    }

    public function getUserByEmail($email)
    {
        return User::where('email', $email)->first();
    }

    public function checkUserByExistence(): array
    {
        $response = [ 'type' => 4, "exist" => false, "message" => "El correo electronico que ha ingresado no se encuentra registrado en nuestra base de datos"];

        if (!empty($this->getUserByEmail($this->postData['email']))) {
            $this->foundUserByEmail = $this->getUserByEmail($this->postData['email']);
            $response = [ 'type' => 1, "exist" => true, "message" => "OK. user by email has been found!", "icono" => 'success'];
        }

        return $response;
    }

    public function changePassword()
    {
        $newPasswordkMask = str_random(5);
        $newHashedPassword = Hash::make($newPasswordkMask);
        $this->newHashedPassword = $newPasswordkMask;
        $this->foundUserByEmail->update(
            [
                "requestPasswordChange" => 1,
                "passwordMask" => $newPasswordkMask,
                "password" => $newHashedPassword,
            ]
        );
    }

    public function sendEmail()
    { 
        $data = Mail::to($this->postData['email'])->send(new SendMailable($this->foundUserByEmail->name, $this->newHashedPassword, $this->foundUserByEmail->email ));
    }
   
}
