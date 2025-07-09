<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Matchs extends Model
{
    use HasFactory;
    
    protected $table = 'matches';
  

    protected $fillable = ['tournament_id', 'team_one', 'team_two', 'team_one_score', 'team_two_score', 'match_date'];

    public function tournament()
    {
        return $this->belongsTo(Tournament::class);
    }
}
