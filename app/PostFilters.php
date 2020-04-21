<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PostFilters extends Model
{
    //
    protected $primaryKey = 'postFiltersId';

    protected $table = 'posts_filters';

    public static function getAllNestedData()
    {
        $filters = PostFilters::all();
        foreach ($filters as $filterIndex => $filter) {
            $filter['selectValues'] = PostFiltersValues::where( ["postFilterId" => $filter->postFiltersId, 'postFiltersSubFilterId' =>0 ])->get();
            $filter['subFilters'] = PostSubFilters::where("postFilterId", $filter->postFiltersId)->get();
            foreach ($filter['subFilters'] as $subfilterkey => $subfilter) {
                $filter['subFilters'][$subfilterkey]['selectValues'] = PostFiltersValues::where([
                    "postFilterId" => $filter->postFiltersId,
                    "postFiltersSubFilterId" => $subfilter->postFiltersSubFilterId,
                ])->get();
            }
        }
        return $filters;
    }
}
