<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PostTags extends Model
{
    use SoftDeletes;
    //
    protected $primaryKey = 'postTagsId';

    protected $table = 'posts_tags';

    protected $fillable = [
        'postId',
        'tagId'
    ];

    public $timestamps = false;
}
