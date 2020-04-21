<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Response as Download;
use DB;

class Posts extends Model
{
	use SoftDeletes;

	protected $primaryKey = 'postId';
	protected $table = 'posts';
	public static $qbuilder = null;
	protected static $filters;
	protected static $searchTextData;
	protected $fillable = [
		'postName',
		'postDescription',
		"userId",
		"miniImageUrl",
		"postTypeId",
		"postCategoryId",
		"postState",
		"awsFilename",
		"fileNameImage",
		"fileNameAWS",
		"downloads"
	];

	public static function getQueryBuilder()
	{
		self::$qbuilder = Posts::select(
			"posts.postId",
			"posts.postCategoryId",
			"posts.miniImageUrl",
			"posts.postName",
			"posts.postDescription",
			"posts.created_at",
			"posts_types.postTypeName",
			"users.name as userName",
			"users.userAvatarFileName",
			"posts.postState",
			"posts.downloads"
		)
			->leftJoin('posts_types', 'posts.postTypeId', '=', 'posts_types.postTypeId')
			->leftJoin('users', 'users.userId', '=', 'posts.userId');
		return self::$qbuilder;
	}

	public static function getPostsBySearchText($searchTextData)
	{
		self::$searchTextData = $searchTextData;
		return Posts::getPostsForModuleList();
	}

	public static function getPostsForModuleList($postId = 0, $filters = [])
	{
		Posts::getQueryBuilder();
		Posts::filterPostsByUserProfile();
		Posts::filterPostsByPostId($postId);
		Posts::applyFilters($filters);
		Posts::filterBySearchText();
		$posts = Posts::dataBusinnesLogic(self::$qbuilder->get());
		Posts::countFavorties($posts);
		return $posts;
	}

	public static function countFavorties($posts, $isArray = false)
	{
		if ($isArray) {
			$posts['favorites'] = PostsFavorites::where("postId", $posts['postId'])->count();
		} else {
			foreach ($posts as $key => $value) {
				$value['favorites'] = PostsFavorites::where("postId", $value['postId'])->count();
			}
		}
		// return $posts;
	}

	public static function filterBySearchText()
	{
		if (!empty(self::$searchTextData) && count(self::$searchTextData) > 0) {
			if (!empty(self::$searchTextData['category']['categoryId'])) {
				// dd(self::$searchTextData['category']['categoryId']);
				self::$qbuilder = self::$qbuilder->where(["postCategoryId" => self::$searchTextData['category']['categoryId']]);
			}
			if (!empty(self::$searchTextData['searchText'])) {
				self::$qbuilder = self::$qbuilder->where('postName', 'like', '%' . self::$searchTextData['searchText'] . '%');
				// ->orWhere('postDescription', 'like', '%' . self::$searchTextData['searchText'] . '%')
			}
		}
	}

	public static function applyFilters($filters)
	{
		if (!empty($filters) && count($filters) > 0) {
			self::$filters = $filters;
			Posts::applyBasicFilters();
			Posts::applyAdvancedFilters();
			Posts::applyPhotographerFilters();
			Posts::applySimilarPostsByCategory();
		}
	}

	public static function filterPostsByUserProfile()
	{


		if (Auth::check()) {
			if (Auth::user()->profileId == 2) {
				self::$qbuilder = self::$qbuilder->where('postCategoryId', "!=", 6); //6 es el Id de la categoria fondos, para que al fotografo no le carguen los fondos
				self::$qbuilder = self::$qbuilder->getPostsByProfile(Auth::user()->userId);
			}
			if (Auth::user()->profileId == 3) {
				self::$qbuilder = self::$qbuilder->where('postState', 1);
			}
		} else {
			self::$qbuilder = self::$qbuilder->where('postCategoryId', "=", 6);
		}
	}

	public static function filterPostsByPostId($postId)
	{
		if ($postId != 0) {
			self::$qbuilder = self::$qbuilder->getPostById($postId);
		}
	}

	public static function applyBasicFilters()
	{
		if (!empty(self::$filters['categories']['postCategoryId'])) {
			self::$qbuilder = self::$qbuilder->getPostsByCategory(self::$filters['categories']['postCategoryId']);
		}
		if (!empty(self::$filters['tags'])) {

			// dd(self::$filters['tags']);
			$tagsAllow = true;
			foreach (self::$filters['tags'] as $fkey => $fvalue) {
				if ($fvalue == 0) {
					$tagsAllow = false;
				}
			}
			if ($tagsAllow) { }
			self::$qbuilder = self::$qbuilder->join('posts_tags', 'posts_tags.postId', '=', 'posts.postId')->whereIn('posts_tags.tagId', array_values(self::$filters['tags']))->groupby('posts.postId');
		}
	}

	public static function applyAdvancedFilters()
	{
		Posts::getPostsByImageExtension();
		Posts::getPostsByUser();
		if (!empty(self::$filters['filterForm']) && count(self::$filters['filterForm']) > 0) {
			Posts::resetSubfilters();
			$subfilterValues = Posts::excludeNotApplicableFilters();
			Posts::applyFilterForConPersonasIsNO();
			Posts::applySubFilters($subfilterValues);
		}
	}

	public static function applyPhotographerFilters()
	{
		if (!empty(self::$filters['photographerfilters'])) {
			switch (self::$filters['photographerfilters']['firstFilter']) {
				case 'publishdate':
					self::$qbuilder = self::$qbuilder->orderby('created_at', self::$filters['photographerfilters']['secondFilter']);
					break;
				case 'download':
					self::$qbuilder = self::$qbuilder->orderby('downloads', self::$filters['photographerfilters']['secondFilter']);
					break;
				case 'favorites':
					self::$qbuilder = self::$qbuilder->orderby('favorites', self::$filters['photographerfilters']['secondFilter']);
					break;
			}
		}
	}

	public static function applySimilarPostsByCategory()
	{

		if (!empty(self::$filters['similarPostsFilter'])) {
			if (!empty(self::$filters['similarPostsFilter']["postCategoryId"])) {
				// dd(self::$filters);
				self::$qbuilder = self::$qbuilder->getPostsByCategory(self::$filters['similarPostsFilter']["postCategoryId"])->where('postId', "!=", self::$filters['similarPostsFilter']["postId"]);
			}
		}
	}

	public static function getPostsByImageExtension()
	{
		if (!empty(self::$filters['imageExtension']) && strlen(self::$filters['imageExtension']) > 0) {
			self::$qbuilder = self::$qbuilder->where(DB::raw('SUBSTRING_INDEX( posts.awsFilename, ".", -1 )'), self::$filters['imageExtension']);
		}
	}

	public static function getPostsByUser()
	{
		if (!empty(self::$filters['userId']) && intval(self::$filters['userId']) != 0) {
			self::$qbuilder = self::$qbuilder->where('posts.userId', self::$filters['userId']);
		}
	}

	public static function resetSubfilters()
	{
		$itemName = '';
		foreach (self::$filters['filterForm'] as $key => $value) {
			if (intval($value) == 4 || $value == '') {
				$itemName = $key;
			}
			// dd($key, $itemName);
			if (strlen($itemName) > 0) {
				if (strpos($key, $itemName) !== false && intval($value) != 4) {
					unset(self::$filters['filterForm'][$key]);
				}
			}
		}
	}

	public static function excludeNotApplicableFilters()
	{
		//Excluir a si y no de los filtros
		$subfilterValues = array_filter(array_values(self::$filters['filterForm']), function ($val) {
			if (!empty($val) && (intval($val) != 3)) {
				return $val;
			}
		});
		return $subfilterValues;
	}

	public static function applyFilterForConPersonasIsNO()
	{
		$filterQuantity = count(self::$filters['filterForm']);
		if ($filterQuantity == 1) {
			$filterValueConPersonas = array_values(self::$filters['filterForm'])[0];
			if ($filterValueConPersonas == 3) {
				self::$qbuilder = self::$qbuilder->join('post_filters_saved', 'post_filters_saved.postId', '=', 'posts.postId')
					->where('post_filters_saved.filterValue', $filterValueConPersonas)
					->whereNull('post_filters_saved.deleted_at')
					->groupby('posts.postId');
			}
		}
	}

	public static function applySubFilters($subfilterValues)
	{
		if (!empty($subfilterValues) && count($subfilterValues) > 0) {
			self::$qbuilder = self::$qbuilder->join('post_filters_saved', 'post_filters_saved.postId', '=', 'posts.postId')
				->whereIn('post_filters_saved.filterValue', $subfilterValues)
				->whereNull('post_filters_saved.deleted_at')
				->groupby('posts.postId');
		}
	}

	public static function getPost($postId)
	{
		$qbuilder = Posts::select(
			"posts.postId",
			"posts.postName",
			"posts.userId",
			"posts.postCategoryId",
			"posts.postTypeId",
			"posts.postDescription",
			"posts.postState",
			"posts.miniImageUrl",
			"posts.awsFilename",
			"posts.fileNameImage",
			"posts.fileNameAWS",
			"posts.downloads",
			"posts.created_at",
			"categories.categoryName",
			"posts_types.postTypeName",
			"users.userAvatarFileName",
			"users.name as autorName"

		)
			->leftJoin('posts_types', 'posts.postTypeId', '=', 'posts_types.postTypeId')
			->leftJoin('users', 'users.userId', '=', 'posts.userId')
			->leftJoin('categories', function ($join) {
				$join->on('categories.categoryId', '=', 'posts.postCategoryId');
			})
			->where('posts.postId', $postId);
		$posts = $qbuilder->first();
		$posts['postState'] =  $posts['postState'] == 1 ? true : false;
		Posts::bindTagsToPost($posts, $postId);
		Posts::bindFiltersToPost($posts, $postId);
		Posts::bindDataFilesToPost($posts);
		Posts::findPostFavorite($posts);
		Posts::countFavorties($posts, 1);
		Posts::bindStatistics($posts);
		return ($posts);
	}

	public static function findPostFavorite($post)
	{
		$qDataFavorite = PostsFavorites::select('postFavoriteId')->where(["userId" => Auth::user()->userId, "postId" => $post['postId']]);
		$qDataFavoriteCount = $qDataFavorite->get()->count();
		$qDataFavoriteId = $qDataFavorite->first()['postFavoriteId'];
		$post['currentUserFavorite'] =  [
			"postFavoriteId" => $qDataFavoriteCount > 0 ? $qDataFavoriteId : 0,
		];
	}

	public static function bindTagsToPost($posts, $postId)
	{
		$posts['postTags'] = PostTags::where("postId", $postId)->get();
		foreach ($posts['postTags'] as $key => $value) {
			$value["tagName"] = TagsGroupTags::select('tagName')->where('tagId', $value['tagId'])->first()->tagName;
			$value['vmodel'] = [
				"name" => 'groupId:' . TagsGroupTags::select('tagGroupId')->where('tagId', $value['tagId'])->first()->tagGroupId . "_tagId:" . $value['tagId']
			];
		}
	}

	public static function bindFiltersToPost($posts, $postId)
	{
		$posts['postFilters'] = PostFiltersSaved::where("postId", $postId)->get();
		foreach ($posts['postFilters'] as $key => $value) {

			$data = 'postFiltersId:' . $value['filterId'] . "_postFilterName:" . $value['filterName'];
			$arrFilter = explode('-', $value['filterId']);
			$arrFilterName = explode('-', $value['filterName']);
			if (!empty($arrFilter) && count($arrFilter) > 1) {
				$data =  'postFiltersId:' . $arrFilter[0] . "_postFilterName:" . $arrFilterName[0] . "_postFiltersSubFilterId:" . $arrFilter[1] . "_postFilterSubFilterName:" . $arrFilterName[1];
			}

			$value['vmodel'] = [
				"name" => $data,
				"value" => $value['filterValue']
			];
			$value['readOnlyValues'] = [
				"key" => !empty($arrFilter) && count($arrFilter) > 1 ?
					PostSubFilters::select("postFilterSubFilterName")->where(["postFiltersSubFilterId" => $arrFilter[1], "postFilterId" => $arrFilter[0]])->get()[0]->postFilterSubFilterName : PostFilters::select("postFilterName")->where(["postFiltersId" => $value['filterId']])->get()[0]->postFilterName,
				"value" => PostFiltersValues::select("postFilterValue")->where(["postFiltersValueId" => $value['filterValue']])->get()[0]->postFilterValue
			];
		}
	}

	public static function bindDataFilesToPost($posts)
	{
		$posts['originalPhotoFile'] = [
			'url' => 'endUserFiles/postFiles/' . $posts->awsFilename,
			'loadedFileName' =>  $posts->fileNameImage,
			"file" => null,
			"downloadLink" => \Storage::disk('s3')->url($posts->awsFilename),
			"size" => self::formatBytes(\Storage::disk('s3')->size($posts->awsFilename)),
			// "downloadLink" => self::download_config($posts->awsFilename)
		];
		$posts['lowQualityFile'] = [
			'url' => 'endUserFiles/postFiles/' . $posts->miniImageUrl,
			'loadedFileName' =>  $posts->fileNameAWS,
			"file" => null

		];
	}

	public static function download_config(Config $config)
	{
		$headers = [
			'Content-Type'        => 'Content-Type: application/zip',
			'Content-Disposition' => 'attachment; filename="' . $config->name . '"',
		];

		return Download::make(Storage::disk('s3')->get($config->path), Response::HTTP_OK, $headers);
	}

	public static function dataBusinnesLogic($data)
	{
		if (Auth::check()) {
			foreach ($data as $key => $value) {
				foreach ($value as $skey => $svalue) {
					$value['postState'] =  $value['postState'] == 1 ? true : false;
					$qDataFavorite = PostsFavorites::select('postFavoriteId')->where(["userId" => Auth::user()->userId, "postId" => $value['postId']]);
					$qDataFavoriteCount = $qDataFavorite->get()->count();
					$qDataFavoriteId = $qDataFavorite->first()['postFavoriteId'];
					$value['currentUserFavorite'] =  [
						"postFavoriteId" => $qDataFavoriteCount > 0 ? $qDataFavoriteId : 0,
					];
				}
			}
		}

		return $data;
	}

	public static function bindStatistics($post)
	{
		$post['postStadistics'] = [
			"postDownloads" => self::getPostDownloads($post['postId']),
			"postFavorites" => self::getPostFavorites($post['postId']),
			"postProjects" => self::getPostProjects($post['postId']),
			"postUsers" => self::getPostUsers($post['postId']),
		];
	}

	public static function getPostDownloads($postId)
	{
		return Posts::select(DB::Raw('COUNT(posts_user_projects.`postsUserProjectsId`) as postDownloads'))
			->leftjoin('posts_user_projects', 'posts_user_projects.postId', '=', 'posts.postId')
			->where('posts.postId', $postId)
			->groupby('posts.postId')->first()->postDownloads;
	}

	public static function getPostFavorites($postId)
	{
		return Posts::select(DB::Raw('COUNT(posts_favorites.`postFavoriteId`) as postFavorites'))
			->leftjoin('posts_favorites', 'posts_favorites.postId', '=', 'posts.postId')
			->where('posts.postId', $postId)
			->groupby('posts.postId')->first()->postFavorites;
	}

	public static function getPostProjects($postId)
	{
		return Posts::select(DB::Raw('COUNT(users_projects.`usersProjectId`) as postProjects'))
			->leftjoin('posts_user_projects', 'posts_user_projects.postId', '=', 'posts.postId')
			->leftjoin('users_projects', 'users_projects.usersProjectId', '=', 'posts_user_projects.projectId')
			->where('posts.postId', $postId)
			->groupby('posts.postId')->first()->postProjects;
	}

	public static function getPostUsers($postId)
	{
		return User::select('users.userId')
			->leftjoin('users_projects', 'users_projects.userId', '=', 'users.userId')
			->leftjoin('posts_user_projects', 'posts_user_projects.projectId', '=', 'users_projects.usersProjectId')
			->where('posts_user_projects.postId', $postId)
			->groupby('users.userId')->get()->count();
	}

	public function scopeGetPostsByProfile($query, $id)
	{
		return $query->where('users.userId', $id);
	}

	public function scopeGetPostById($query, $id)
	{
		return $query->where('posts.postId', $id);
	}

	public function scopeGetPostsByCategory($query, $id)
	{
		return $query->where('posts.postCategoryId', $id);
	}

	public static function formatBytes($bytes, $precision = 2)
	{
		$units = array('B', 'KB', 'MB', 'GB', 'TB');

		$bytes = max($bytes, 0);
		$pow = floor(($bytes ? log($bytes) : 0) / log(1024));
		$pow = min($pow, count($units) - 1);

		// Uncomment one of the following alternatives
		$bytes /= pow(1024, $pow);
		// $bytes /= (1 << (10 * $pow)); 

		return round($bytes, $precision) . ' ' . $units[$pow];
	}
}
