<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PostsUserProjects extends Model
{
    use SoftDeletes;
    protected $table = 'posts_user_projects';
    protected $primaryKey = 'postsUserProjectsId';
    protected $fillable = [
         'postId',
         'projectId'
    ];

}
 