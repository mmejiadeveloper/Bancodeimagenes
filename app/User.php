<?php

namespace App;

use DB;
use Illuminate\Notifications\Notifiable;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;
use App\Notifications\ResetPassword;

class User extends Authenticatable
{
    use Notifiable;

    protected $primaryKey = 'userId';
    protected $table = 'users';
    protected $hidden = [
        'password', 'remember_token',
    ];
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];
    protected $fillable = [
        'name',
        'email',
        'password',
        'passwordMask',
        'phoneNumber',
        'profileId',
        'userState',
        'userDepartmentId',
        'userAvatarFileName',
        'requestPasswordChange',
        'identificationNumber',
    ];

    public static function getUsersForModuleList($filters = [])
    {
        $qbuilder = User::select(
                "users.name",
                "users.email",
                "users.passwordMask",
                "users.phoneNumber",
                "users_deparments.userDepartmentId",
                "users_deparments.departmentName",
                "users.userState",
                "users.created_at",
                "users.profileId",
                "profiles.profileName",
                "users.userId",
                "users.userAvatarFileName",
                "users.identificationNumber",
                DB::Raw('count(posts.postId) as items'),
                DB::Raw('count(posts_user_projects.postsUserProjectsId)  as downloads')
            )
            ->leftJoin('users_deparments', 'users.userDepartmentId', '=', 'users_deparments.userDepartmentId')
            ->leftJoin('profiles', 'users.profileId', '=', 'profiles.profileId')
            ->leftJoin('posts', 'users.userId', '=', 'posts.userId')
            ->leftJoin('users_projects', 'users_projects.userId', '=', 'users.userId')
            ->leftJoin('posts_user_projects', 'posts_user_projects.projectId', '=', 'users_projects.usersProjectId');
            
            if( !empty( $filters ) && count( $filters ) > 0  ) {
                if( $filters['param'] == "type" ) {
                    if(!empty($filters['profileId'])) {
                        // dd($filters);
                        $qbuilder = $qbuilder->getByProfile($filters['profileId']);    
                    }
                }
                if( $filters['param'] == "department" ) {
                    if(!empty($filters['userDepartmentId'])) {
                        $qbuilder = $qbuilder->getByDepartment($filters['userDepartmentId']);    
                    }
                }
            }
           
            $qbuilder = $qbuilder->groupBy('users.userId');
            $users = $qbuilder->get();
        // dd($users);
        return User::dataBusinnesLogic($users);
    }

    public static function dataBusinnesLogic($data)
    {
        foreach ($data as $key => $value) {
            foreach ($value as $skey => $svalue) {
                // $value['userState'] = intval($value['userState'] );
                $value['userState'] = intval($value['userState'] );
                $value['ckuserState'] =  $value['userState'] == 1 ? true : false;
                /* if($value['userState'] !=0 ) {
                    if($value['userState'] == 1) {
                        $value['userState'] == true;
                    } 
                    if($value['userState'] == 2) {
                        $value['userState'] == false;
                    }
                } */
               
                $value['loadedFileExistence'] =  User::checkUserAvatarPhotoExistence($value);
            }
        }
        return $data;
    }

    public static function checkUserAvatarPhotoExistence($row)
    {
        return \Storage::disk("endUserFiles")->exists('usersAvatar/' . $row['userAvatarFileName']);
    }

    public function scopeGetByProfile($query, $id)
	{
		return $query->where('users.profileId', $id);
	}
    public function scopeGetByDepartment($query, $id)
	{
		return $query->where('users.userDepartmentId', $id);
    }
    
    public function sendPasswordResetNotification($token)
    {
        $this->notify(new ResetPassword($token));
    }

    public function swapping($user) {
        $new_sessid   = \Session::getId(); //get new session_id after user sign in
        $last_session = \Session::getHandler()->read($user->last_sessid); // retrive last session
    
        if ($last_session) {
            if (\Session::getHandler()->destroy($user->last_sessid)) {
                // session was destroyed
            }
        }
    
        $user->last_sessid = $new_sessid;
        $user->save();
    }
}
