<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;

use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
      // Register a new user
      public function register(Request $request)
      {
          $validated = $request->validate([
              'name' => 'required|string|max:255',
              'email' => 'required|string|email|max:255|unique:users',
              'password' => 'required|string|min:8',
          ]);
  
          $user = User::create([
              'name' => $validated['name'],
              'email' => $validated['email'],
              'password' => Hash::make($validated['password']),
          ]);
  
          $token = $user->createToken('auth_token')->plainTextToken;
  
          return response()->json([
              'user' => $user,
              'token' => $token,
              'success' => true,
          ]);
       
      }
  
            // Login an existing user
            public function login(Request $request)
            {
                $validated = $request->validate([
                    'email' => 'required|string|email',
                    'password' => 'required|string',
                ]);


                // Check if user exists and password is correct
            if (!($user = User::where('email', $validated['email'])->first()) || 
            !Hash::check($validated['password'], $user->password)) {
            return response()->json([
                
                'message' => 'Invalid credentials',
            ], 401);
        }

        // Create a token if login is successful
        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'success' => true,
            'message' => 'Login successful',
            'user' => $user,
            'token' => $token,
        ], 200); 
  
        
       
      }
  
      // Get authenticated user details
      public function user(Request $request)
      {
          return $request->user();
      }
}
