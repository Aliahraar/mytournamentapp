<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\MatchController;
use App\Http\Controllers\TournamentController;
use App\Http\Controllers\ProfileController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/matches', [MatchController::class, 'store']);
Route::get('/tournaments', [TournamentController::class, 'index']);
Route::get('/tournaments/{id}/matches', [MatchController::class, 'getMatchesByTournament']);
Route::delete('/tournaments/{id}', [TournamentController::class, 'destroy']);
Route::middleware('auth:sanctum')->get('/profile', [ProfileController::class, 'getProfile']);


Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
