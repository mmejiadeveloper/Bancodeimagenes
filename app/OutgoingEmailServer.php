<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class OutgoingEmailServer extends Model
{
    //
    protected $table = 'outgoing_emailserver';

    protected $primaryKey = 'id';

    protected $fillable = [
        'allowCustomSTMP',
        'integration',
        "APIKEY",
        "outgoingEmailAccount",
        "passwordOutgoingEmailAccount",
        "updatedBy",
    ];
}
 