<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class TagsGroups extends Model
{
	//
	protected $primaryKey = 'tagGroupId';

	protected $table = 'tags_groups';

	protected $fillable = [
		'tagGroupName',
	];

	public static function getAllNestedData()
	{
		$tagGroups = TagsGroups::all();
		foreach ($tagGroups as $tagIndex => $tagGroup) {
			$data = TagsGroupTags::select(
				'tags_group_tags.tagGroupId',
				'tags_group_tags.tagId',
				'tags_group_tags.tagName',
				'posts_tags.postTagsId'
			)
			->leftjoin('posts_tags','posts_tags.tagId','=','tags_group_tags.tagId')
			->where("tagGroupId", $tagGroup->tagGroupId)
			->groupby('tags_group_tags.tagId')
			->get();
			$tagGroup['tags'] = $data;
		}
		return $tagGroups;
	}
}
