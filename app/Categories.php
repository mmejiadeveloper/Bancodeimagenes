<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use DB;
class Categories extends Model
{

    use SoftDeletes;

    protected $primaryKey = 'categoryId';

    protected $table = 'categories';

    protected $fillable = [
        'categoryName',
        'createdBy',
        "state"
    ];

    public static function getCategoriesByGodProfile()  {
        return Categories::
        select(
            "categoryId",
            "categoryName",
            DB::Raw(' (
                SELECT count(postId) FROM posts WHERE postCategoryId = categories.categoryId  
            ) as numberOfPosts ')
        )->from('categories as categories')
        ->orderby('categoryName','asc')
        ->get();
    }
    
    public static function getCategoriesByNotGodProfile($idProfile)  {
        return Categories::
        select(
            "categoryName",
            "categoryId",
            DB::Raw(' (
                SELECT count(postId) FROM posts WHERE postCategoryId = categories.categoryId and postState = 1
            ) as numberOfPosts ')
        )->from('categories as categories')
        ->orderby('categoryName','asc')
        ->get();
    }
}
