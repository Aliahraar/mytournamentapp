<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tournament extends Model
{
    use HasFactory;
    protected $fillable = ['name']; // Add 'name' as fillable

    public function matches()
    {
        return $this->hasMany(Matchs::class);
    }
}
