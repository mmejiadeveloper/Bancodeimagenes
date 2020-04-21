<?php

namespace App\Http\Controllers\AppTemplate\Modules\PostsControllers;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use App \ {
	Posts,
	PostTags,
	PostFiltersSaved
};
use Illuminate\Support\Facades\Auth;
use DB;

class SavePostController extends Controller
{
	protected $postData;
	protected $postPhotos;
	protected $uploadProccess;
	protected $lastPostId;
	public $lastUploadedMiniImage;
	public $lastUploadedAWSFile;
	public $post; //Only for update

	const FILE_SIZE_LIMIT = 30000000;
	const FILE_ALLOWED_EXTENSIONS = ["jpg", "png", "tif"];

	public function __construct()
	{
		$this->postData = isset($_POST['data']) ? $this->axiosDataToAssocArray(json_decode($_POST['data'])) : [];
		$this->uploadProccess = 'FAILED';
		$this->post = $this->postData['mode'] == 'update' ?  Posts::findOrFail($this->postData['postId']) : null;
	}

	public function savePost(Request $request)
	{
		$response = ["type" => 2, "message" => "Hubo un error al subir el archivo al sistema, verifique de que la extension sea permitida al igual que el tama&ntilde;o"];
		try {
			$this->savePostInfo();
			$this->saveTagsInfo();
			$this->saveFiltersInfo();
			$this->uploadFiles($request);
			if ($this->uploadProccess == "OK") {
				$response = ["type" => 1, "message" => "ok"];
			}
		} catch (\Throwable $th) {
			$response = $this->errorReporting($th);
		}
		return $response;
	}

	public function savePostInfo()
	{
		if (empty($this->postData['userId'])) {
			$this->postData['userId'] = Auth::user()->userId;
		}
		if ($this->postData['mode'] == 'create') {
			$this->lastPostId = Posts::create(
				$this->postData
			)->getKey();
		} else {

			Posts::findOrFail($this->postData['postId'])->update($this->postData);
		}
	}

	public function saveTagsInfo()
	{

		PostTags::where(["postId" => $this->postData['mode'] == "create" ?  $this->lastPostId : $this->postData['postId']])->delete();
		DB::transaction(function () {
			foreach ($this->postData['tagsForm'] as $key => $value) {
				$tagItem = explode('_', $key)[1];
				$tagId = explode(':', $tagItem)[1];

				if ($value == true) {
					$tagItem = explode('_', $key)[1];
					$tagId = explode(':', $tagItem)[1];
					PostTags::create(
						[
							"postId" => $this->postData['mode'] == "create" ?  $this->lastPostId : $this->postData['postId'],
							"tagId" => $tagId
						]
					);
				}
			}
		});
	}

	public function saveFiltersInfo()
	{
		DB::transaction(function () {
			$updateSubFilters = $this->checkForSubFiltersUpdate();
			foreach ($this->postData['filterForm'] as $key => $value) {
				if (!empty($value)) {
					$filterData = $this->prepareFilterValues($key);

					if ($this->postData['mode'] == 'create') {
						$this->createFilterAndSubfilter($filterData, $value);
					} else {
						PostFiltersSaved::where(["postId" => $this->postData['mode'] == 'update' ? $this->postData['postId'] : $this->lastPostId, "filterId" => $filterData['filterId']])->delete();
						if ($updateSubFilters) {
							$this->createFilterAndSubfilter($filterData, $value);
						}
					}
				}
			}
		});
	}

	public function checkForSubFiltersUpdate()
	{
		$filterFormArrayValues = array_values($this->postData['filterForm']);
		$updateSubFilters = false;
		if (in_array(3, $filterFormArrayValues) || in_array(4, $filterFormArrayValues)) {
			$updateSubFilters = true;
		}
		return $updateSubFilters;
	}

	public function createFilterAndSubfilter($filterData, $value)
	{
		PostFiltersSaved::create(
			[
				"filterId" => $filterData['filterId'],
				"filterName" => $filterData['filterName'],
				"filterValue" => $value,
				"postId" => $this->postData['mode'] == 'update' ? $this->postData['postId'] : $this->lastPostId,
			]
		);
	}

	public function prepareFilterValues($key)
	{
		$filterItemWithId = explode('_', $key)[0];
		$filterItemWithName = explode('_', $key)[1];
		$filterId = explode(':', $filterItemWithId)[1];
		$filterName = explode(':', $filterItemWithName)[1];
		if (count(explode('_', $key)) > 2) {
			$filterId .= "-" . explode(':',  explode('_', $key)[2])[1];
			$filterName .= "-" . explode(':',  explode('_', $key)[3])[1];
		}
		return [
			"filterId" => $filterId,
			"filterName" => $filterName,
		];
	}

	public function uploadFiles($request)
	{
		$this->validateFileExistenceAndAssignPropierty($request);
		$this->createExpectedDataPropierty();
		$this->loadFileExtension();
		$this->loadFileName();
		$this->bindFileNameToDataRow();
		$this->captureLastPostFiles();
		$this->uploadProfileAvatarPhoto();
	}

	public function validateFileExistenceAndAssignPropierty($request)
	{
		$this->postPhotos = $request->hasFile('files') ?  $request->file('files') : [];
	}

	public function createExpectedDataPropierty()
	{
		if (!empty($this->postPhotos)) {
			foreach ($this->postPhotos as $key => $value) {
				$value->expectedData = [];
				$value->expectedData['fileType'] = $key == 0 ? 'serverImange' : 'AWSImage';
			}
		}
	}

	public function loadFileExtension()
	{
		if (!empty($this->postPhotos)) {
			foreach ($this->postPhotos as $key => $value) {
				$this->validateFileExtensionType(pathinfo($value->getClientOriginalName())['extension']);
				
				$value->expectedData['loadedExtension'] = pathinfo($value->getClientOriginalName())['extension'];;
			}
			$this->validateFileSize($value);
		}
	}

	public function validateFileExtensionType($extension)
	{
		$this->profileAvatarPhoto->expectedData['status'] = in_array($extension, self::FILE_ALLOWED_EXTENSIONS) ? "OK" : "failed: Extension is not valid";
	}
	public function validateFileSize($file)
	{
		$this->profileAvatarPhoto->expectedData['status'] = $this->postPhotos[1]->getSize() <= self::FILE_SIZE_LIMIT ? "OK" : "failed: Size is not valid";
	}

	public function loadFileName()
	{
		foreach ($this->postPhotos as $key => $value) {
			if (!empty($value)) {
				$postId= "PID_" . ($this->postData['mode'] == 'update' ? $this->postData['postId'] : $this->lastPostId );
				$userId = "_US_" . Auth::user()->userId;
				$date = "_DATE_" . date('YmdHis');
				$extension = "." . $value->expectedData['loadedExtension'];
				$value->expectedData['fileName'] = $postId. $userId. $date. $extension;
			}
		}
	}

	public function bindFileNameToDataRow()
	{
		if (count($this->postPhotos) > 0) {
			$this->postData['miniImageUrl'] = $this->postPhotos[0]->expectedData['fileName'];
			$this->postData['awsFilename'] = $this->postPhotos[1]->expectedData['fileName'];
		}
	}

	public function captureLastPostFiles()
	{
		if (count($this->postPhotos) > 1  && $this->postData['miniImageUrl'] != 'default' && $this->postData['awsFilename'] != 'default') {
			$loadedPost = Posts::findOrFail($this->postData['mode'] == 'create' ? $this->lastPostId : $this->postData['postId']);
			if (!empty($loadedPost) && strlen($this->lastUploadedMiniImage) > 0 && strlen($this->lastUploadedAWSFile) > 0) {
				$this->lastUploadedMiniImage =  $loadedPost->miniImageUrl;
				$this->lastUploadedAWSFile =  $loadedPost->awsFilename;
			}
		}
	}

	public function uploadProfileAvatarPhoto()
	{
		if (count($this->postPhotos) > 0) {
			// dd($this->profileAvatarPhoto->expectedData['status']);
			if($this->profileAvatarPhoto->expectedData['status'] == 'OK') {
				// if (\Storage::disk("endUserFiles")->put("/postFiles/" . $this->postData['miniImageUrl'],  \File::get($this->postPhotos[0])) && \Storage::disk("endUserFiles")->put("/postFilesAWS/" . $this->postData['awsFilename'],  \File::get($this->postPhotos[1]))) {
				if (\Storage::disk("endUserFiles")->put("/postFiles/" . $this->postData['miniImageUrl'],  \File::get($this->postPhotos[0])) ) {
					$this->checkAndRemoveLastProfilePhoto();
					$this->updatePostFileData();
					\Storage::disk('s3')->put( 
						$this->postPhotos[1]->expectedData['fileName'], 
						fopen($this->postPhotos[1], 'r+'), 
						[
							'visibility' => 'public',
							'mimetype' => 'application/zip'
						]
					);
					$this->uploadProccess = "OK";
				}
			}
			
		}
		if ($this->postData['mode'] == 'update') {
			if (count($this->postPhotos) <= 0) {
				$this->uploadProccess = "OK";
			}
		}
	}

	public function updatePostFileData()
	{
		Posts::findOrFail($this->postData['mode'] == 'create' ? $this->lastPostId : $this->postData['postId'])->update(
			[
				"miniImageUrl" => $this->postData['miniImageUrl'],
				"awsFilename" => $this->postData['awsFilename'],
				"fileNameImage" => $this->postPhotos[0]->getClientOriginalName(),
				"fileNameAWS" => $this->postPhotos[1]->getClientOriginalName(),
			]
		);
	}

	public function checkAndRemoveLastProfilePhoto()
	{
		if ($this->postData['mode'] == 'update' && count($this->postPhotos) > 0) {
			if ($this->postData['miniImageUrl']  != 'default.jpg' && $this->postData['awsFilename']  != 'default.jpg') {
				if (\Storage::disk("endUserFiles")->exists('postFiles/' . $this->post['miniImageUrl'])) {
					\Storage::disk("endUserFiles")->delete('postFiles/' . $this->post['miniImageUrl']);
					\Storage::disk('s3')->delete($this->post['awsFilename']);
				}
				/* if (\Storage::disk("endUserFiles")->exists('postFilesAWS/' . $this->post['awsFilename'])) {
					\Storage::disk("endUserFiles")->delete('postFilesAWS/' . $this->post['awsFilename']); 
					
				} */
			}
		}
	}
}
