<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;

class ProfileController extends Controller
{
    public function getProfile(Request $request)
    {
        // Get the currently authenticated user
        $user = $request->user();

        return response()->json([
            'name' => $user->name,
            'email' => $user->email,
            'phone' => $user->phone ?? 'Not available', // Optional field
            'address' => $user->address ?? 'Not available', // Optional field
            'profile_picture' => 'https://via.placeholder.com/120', // Replace with actual image URL
        ]);
    }
}
