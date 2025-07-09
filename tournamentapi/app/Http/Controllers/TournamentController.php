<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Tournament;

class TournamentController extends Controller
{
    public function index()
    {
        // Fetch all tournaments
        $tournaments = Tournament::all();
        
        return response()->json($tournaments);
    }
    public function destroy($id)
{
    $tournament = Tournament::find($id);

  

    $tournament->delete();

    return response()->json(['message' => 'Tournament deleted successfully'], 200);
  

    
}

}
