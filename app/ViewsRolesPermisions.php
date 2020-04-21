<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\UserViews;
use Auth;

class ViewsRolesPermisions extends Model
{
    protected $table = 'views_roles_permisions';
    protected $primaryKey = 'viewsRolesPermisionsId';

    public static function getViews () {
        $qbuilder = UserViews::join('views_roles_permisions', "views_roles_permisions.viewProfileId", "=", "users_views.viewId")
        ->where([
            "views_roles_permisions.userProfileId" => Auth::user()->profileId
        ])->groupby('users_views.viewId')
        ->orderBy('users_views.order');
        return $qbuilder->get();
    }

}
