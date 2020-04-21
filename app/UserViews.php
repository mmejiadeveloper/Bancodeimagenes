<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class UserViews extends Model
{
    protected $table = 'users_views';
    protected $primaryKey = 'viewId';
}
