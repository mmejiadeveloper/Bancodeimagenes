<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use DB;
class PostsFavorites extends Model
{
    protected $primaryKey = 'postFavoriteId';
    protected $table = 'posts_favorites';
    protected $fillable = [
        'userId',
        'postId',
    ];
    protected static $qbuilder = null;
    protected static $filters;
    

    public static function getPostFavoriteQBuilder()
    {
        return PostsFavorites::where(["userId" => Auth::user()->userId]);
    }

    public static function bindFavoriteData($data)
    {
        $postsTemp = [];
        foreach ($data as $key => $value) {
            $postsTemp[] = Posts::getPost($value['postId']);
        }
        return $postsTemp;
    }

    public static function getFavoriteUsersPosts($filters = [])
    {
        $qbuilder = self::getPostFavoriteQBuilder();
        $downloads = $qbuilder->get();
        return self::bindFavoriteData($downloads);
    }


    public static function getQueryBuilder()
	{
		self::$qbuilder = Posts::select(
			"posts.postId",
			"posts.miniImageUrl",
			"posts.postName",
			"posts.postDescription",
			"posts.created_at",
			"posts_types.postTypeName",
			"users.name as userName",
			"posts.postState",
			"posts.downloads"
		)
            ->join('posts_favorites', function ($join){
                $join->on('posts.postId', '=', 'posts_favorites.postId')
                ->on('posts_favorites.userId', '=', DB::Raw('40') );
            })
			->leftJoin('posts_types', 'posts.postTypeIdx', '=', 'posts_types.postTypeId')
            ->leftJoin('users', 'users.userId', '=', 'posts.userId');
		return self::$qbuilder;
    }
    

    public static function getPostsForModuleList( $filters = [])
	{
        self::getQueryBuilder();
        Posts::$qbuilder = self::$qbuilder;
		Posts::filterPostsByUserProfile();
		Posts::applyFilters($filters);
        Posts::filterBySearchText();
        self::$qbuilder->groupby('posts.postId');
		$posts = Posts::dataBusinnesLogic(self::$qbuilder->get());
		Posts::countFavorties($posts);
		return $posts;
    }
    


}
