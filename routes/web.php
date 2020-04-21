<?php
// Route::get('/{any}', 'HomeController@index')->where('any', '.*');
Route::get('/', 'HomeController@index');

Route::get('login', [ 'as' => 'login', 'uses' => 'Auth\LoginController@showLoginFormX' ]);
Route::get('logout', [ 'as' => 'logout','uses' => 'Auth\LoginController@logout' ]);
Route::post('__restorePassword', ['uses' => 'Auth\ForgotPasswordController@resetUserPassword' ]);

Route::group(['prefix' => 'auth'], function () {
	Route::post('__validate', 'Auth\LoginController@validaUserCredentials');
});

Route::group(['prefix' => 'header'], function () {
	Route::post('__findCategories', 'AppTemplate\HeaderController@getCategories');
	Route::post('__loadViews', 'AppTemplate\HeaderController@getViews');
});

Route::group(['prefix' => 'categories'], function () {
	Route::post('__loadCategories', 'AppTemplate\Modules\SettingsController@getCategories');
	Route::post('__addCategories', 'AppTemplate\Modules\SettingsController@saveCategories');
	Route::post('__modifyCategories', 'AppTemplate\Modules\SettingsController@updateCategories');
	Route::post('__removeCategories', 'AppTemplate\Modules\SettingsController@deleteCategories');
});

Route::group(['prefix' => 'tags'], function () {
	Route::post('__loadGroups', 'AppTemplate\Modules\SettingsController@getTagsGroups');
	Route::post('__loadGroupTags', 'AppTemplate\Modules\SettingsController@getGroupTags'); 
	Route::post('__renameGroup', 'AppTemplate\Modules\SettingsController@updateGroup');
	Route::post('__storeTags', 'AppTemplate\Modules\SettingsController@saveTags');
	Route::post('__modifyTags', 'AppTemplate\Modules\SettingsController@updateTag');
	Route::post('__removeTags', 'AppTemplate\Modules\SettingsController@deleteTags');
});

Route::group(['prefix' => 'usersTypes'], function () {
	Route::post('__loadUserProfiles', 'AppTemplate\Modules\SettingsController@getUserProfiles');
	Route::post('__modifyUserProfiles', 'AppTemplate\Modules\SettingsController@updateUserProfiles');
});

Route::group(['prefix' => 'outgoingemailserver'], function () {
	Route::post('__loadInfo', 'AppTemplate\Modules\SettingsController@getData');
	Route::post('__modifyInfo', 'AppTemplate\Modules\SettingsController@updateData');
});

Route::group(['prefix' => 'users'], function () {
	Route::post('__loadUsers', 'AppTemplate\Modules\UsersController@getUsers');
	Route::post('__modifyUserState', 'AppTemplate\Modules\UsersController@updateUserStatus');
	Route::post('__loadProfilesAndDepartments', 'AppTemplate\Modules\UsersController@getDeparmentsAndProfiles'); 
	Route::post('__addUser', 'AppTemplate\Modules\UsersController@createUser');
	Route::post('__modifyUser', 'AppTemplate\Modules\UsersController@updateUserData');
	Route::post('__modifiyUserData', 'AppTemplate\Modules\UsersController@updateUserData');
	Route::post('__filterUsers', 'AppTemplate\Modules\UsersController@getUsersByFilters');
	Route::post('__loadUserDepartments', 'AppTemplate\Modules\UsersController@getUserDepartments');
	Route::post('__loadUserProjects', 'AppTemplate\Modules\UsersController@getUserProjects');
});

Route::group(['prefix' => 'posts'], function () {
	Route::post('__filter', 'AppTemplate\Modules\PostsController@searchByFilters');
	Route::post('__loadPost', 'AppTemplate\Modules\PostsController@getPost'); 
	Route::post('__loadPosts', 'AppTemplate\Modules\PostsController@getPosts');
	Route::post('__removePost', 'AppTemplate\Modules\PostsController@deletePost');
	Route::post('__modifyPostState', 'AppTemplate\Modules\PostsController@updatePostStatus');
	Route::post('__loadSettings', 'AppTemplate\Modules\PostsController@getSettings');
	Route::post('__addPost', 'AppTemplate\Modules\PostsControllers\SavePostController@savePost');
	Route::post('__modifyPost', 'AppTemplate\Modules\PostsControllers\SavePostController@savePost');
	Route::post('__searchPosts', 'AppTemplate\Modules\PostsController@searchPosts');
	Route::post('__favorite', 'AppTemplate\Modules\PostsController@setFavoritePost');
	Route::post('__andToProjectAndDownload', 'AppTemplate\Modules\PostsController@saveProjectAndDownload');
});

Route::group(['prefix' => 'userProjects'], function () {
	Route::post('__addProject', 'AppTemplate\Modules\UsersProjectsController@saveProject');
	Route::post('__loadUserProjects', 'AppTemplate\Modules\UsersProjectsController@getUserProjects');
	Route::post('__removeUserProject', 'AppTemplate\Modules\UsersProjectsController@deleteUserProject');
	Route::post('__loadUserDownloads', 'AppTemplate\Modules\UsersProjectsController@getUserDownloads');
	Route::post('__filterDownloads', 'AppTemplate\Modules\UsersProjectsController@filterDownloads');
	Route::post('__loadUserFavorites', 'AppTemplate\Modules\UsersProjectsController@getUserFavorites');
	Route::post('__filterFavorites', 'AppTemplate\Modules\UsersProjectsController@searchByFilters');
});

Route::get('/send/email', 'HomeController@mail');

