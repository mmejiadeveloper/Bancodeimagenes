<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Http\Request;

use Auth;
use Hash;
use Session;
use App \ {
    User,
    Posts
};

class LoginController extends Controller
{
    use AuthenticatesUsers;

    protected $foundUserByEmail;
    protected $dataFromUserLogin;
    
    public function __construct()
    {
        // dd(env('DB_DATABASE'));
        $this->middleware('guest')->except('logout');
    }

    protected function authenticated() {
        if (Auth::check()) {
            return redirect()->route('dashboard');
        }
    }

    public function logout(Request $request)
    {
        Auth::logout();
        return redirect("/");
    }

    public function setDataFromUserLogin()
    {
        $this->dataFromUserLogin = isset($_POST['data']) ? $this->axiosDataToAssocArray(json_decode($_POST['data'])) : [];
        return !empty($this->dataFromUserLogin) ? ["response" => true, "message" => 'OK'] : ["response" => false, "message" => 'Esta intentando entrar al sistema de una manera no autorizada. Por ingrese desde la vista del login'];
    }

    public function getUserByEmail($email)
    {
        return User::where('email', $email)->first();
    }

    public function checkUserByExistence(): array
    {
        $response = ["exists" => false, "message" => "El correo electronico que ha ingresado no se encuentra registrado en nuestra base de datos"];

        if (!empty($this->getUserByEmail($this->dataFromUserLogin['email']))) {
            $this->foundUserByEmail = $this->getUserByEmail($this->dataFromUserLogin['email']);
            $response = ["exists" => true, "message" => "OK. user by email has been found!", "icono" => 'success'];
        }

        return $response;
    }

    public function checkUserState(): array
    {
        $response = ["exists" => false, "message" => "El usuario no se existe en el sistema"];
        if (!empty($this->foundUserByEmail)) {
            $response = $this->foundUserByEmail['userState'] ? 
            ["exists" => true, "message" => "OK. user is active in the system", "icono" => 'success'] :
            ["exists" => false, "message" => "El usuario no se encuentra activo en el sistema"] ;
        }
        return $response;
    }

    public function checkAgainstUserFoundPassword()
    {
        $response = [ "type" =>4, "exists" => false, "message" => "Correo o contrase&ntilde;a incorrectos"];
        if (Hash::check($this->dataFromUserLogin['password'], $this->foundUserByEmail['password'])) {
            $this->createUserSession();
            $response = [ "type" =>1, "exists" => true, "message" => "OK. Autenticacion correcta."];
        }
        return $response;
    }

    public function createUserSession()
    {
        Auth::login($this->foundUserByEmail);
    }

    public function validaUserCredentials()
    {
        try {

            if ($response = $this->setDataFromUserLogin()) { //When we deny this method we are preventing to continue if there is not data from POST
                $response = $this->checkUserByExistence();
                $response = $this->checkUserState();
                if ($response['exists']) {
                    $response = $this->checkAgainstUserFoundPassword();
                }
            }
        } catch (\Throwable $th) {
            if($this->debugAsyncRequests) {
                dd( [ "File" => $th->getFile(), "Line" => $th->getLine(), "Message" => $th->getMessage()]);
            }else{
                $response = ["exists" => false, "type" => 3, "message" => "Failure."];
            }
        }
        return json_encode($response);
    }

    public function showLoginFormX () {
        $posts = Posts::getPostsForModuleList();
        $publicPostsForBackgrounds = [];
        if($posts->count() > 0 ) {
            $id = random_int ( 0, $posts->count()-1);
            $publicPostsForBackgrounds = [$posts[$id]] ;
        }
		return view('auth.login', compact('publicPostsForBackgrounds'));
	}
}
