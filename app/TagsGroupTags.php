<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class TagsGroupTags extends Model
{
    use SoftDeletes;

    protected $primaryKey = 'tagId';

    protected $table = 'tags_group_tags';

    protected $fillable = [
        'tagName',
        'createdBy',
        'tagGroupId',
    ];
}
