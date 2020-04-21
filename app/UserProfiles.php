<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class UserProfiles extends Model
{
    protected $primaryKey = 'profileId';

    protected $table = 'profiles';

    protected $fillable = [
        'profileName',
    ];
}
