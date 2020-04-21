<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class PostFiltersSaved extends Model
{
    use SoftDeletes;
    
    protected $primaryKey = 'postFilterSavedId';

    protected $table = 'post_filters_saved';

    protected $fillable = [
        'filterId',
        'filterName',
        'filterValue',
        'postId'
    ];

    public $timestamps = false; 
}
