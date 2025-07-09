<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Matchs;
use App\Models\Tournament;
class MatchController extends Controller
{
    public function store(Request $request)
    {
       
          
        // Create or find the tournament
        $tournament = Tournament::firstOrCreate([
            'name' => $request->tournament_name,
        ]);

        // Save the matches
        foreach ($request->matches as $matchData) {
            Matchs::create([
                'tournament_id' => $tournament->id,
                'team_one' => $matchData['team1'],
                'team_two' => $matchData['team2'],
                'match_date' => now(), // Default match date (or update as needed)
            ]);
        }

        return response()->json([
            'message' => 'Tournament and matches saved successfully!',
            'tournament' => $tournament,
        ], 200);
    }

    public function getMatchesByTournament($tournamentId)
    {
        $tournament = Tournament::with('matches')->findOrFail($tournamentId);

        return response()->json([
            'tournament' => $tournament,
            'matches' => $tournament->matches,
        ]);
    }

  
}
