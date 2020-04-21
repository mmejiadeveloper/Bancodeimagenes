<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PostTypes extends Model
{
    //
    protected $primaryKey = 'postTypeId';

    protected $table = 'posts_types';
}
