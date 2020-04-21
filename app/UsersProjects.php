<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\SoftDeletes;

class UsersProjects extends Model
{
    use SoftDeletes;

    protected $table = 'users_projects';
    protected $primaryKey = 'usersProjectId';

    protected $fillable = [
        'userId',
        'projectName',
    ];

    protected static $usersProjects;

    public static function getProjectsWithPosts()
    {
        self::$usersProjects = UsersProjects::where(["userId" => Auth::user()->userId])->get();
        self::bindFoundPosts();
        return self::$usersProjects;
    }

    public static function bindFoundPosts()
    {
        foreach (self::$usersProjects as $key => $value) {
            $posts =  PostsUserProjects::where(["projectId" => $value['usersProjectId']])->get();
            $value['posts'] = self::getPostDetail($posts, $value);
            $value['options'] = ["visible" => true];
        }
    }

    public static function getPostDetail($posts, $value)
    {
        $postsTemp = [];
        foreach ($posts as $key => $value) {
            $postsTemp[] = Posts::getPost($value['postId']);
        }
        return $postsTemp;
    }

    public static function getPostProjectQBuilder()
    {
        return PostsUserProjects::select('posts_user_projects.postId', 'users_projects.projectName')
            ->leftjoin('users_projects', 'users_projects.usersProjectId', '=', 'posts_user_projects.projectId');
    }

    public static function applyDownloadFilters($filters, $qbuilder)
    {
        $enduserFilters = count($filters) > 0 ?  $filters['enduserfilters'] : [];
        if (!empty($enduserFilters) && count($enduserFilters) > 0) {
            if (!empty($enduserFilters['firstFilter'] && $enduserFilters['secondFilter'])) {
                $qbuilder->orderby($enduserFilters['firstFilter'] , $enduserFilters['secondFilter']);
            }
        }
    }

    public static function bindDownloadData($data)
    {
        $postsTemp = [];
        foreach ($data as $key => $value) {
            $post = Posts::getPost($value['postId']);
            $post['projectName'] =  $value['projectName'];
            $postsTemp[] = $post;
        }
        return $postsTemp;
    }

    public static function getPostsByDownloads($filters = [])
    {
        $qbuilder = self::getPostProjectQBuilder();
        $qbuilder  = $qbuilder->groupby('posts_user_projects.postId');
        self::applyDownloadFilters($filters, $qbuilder);
        $downloads = $qbuilder->get();
        return self::bindDownloadData($downloads);
    }

    public static function getPostsForModuleList () {
        
    }
}
