import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tournament/signup.dart';  // Import the SignUp Page for navigation
import 'package:tournament/main.dart';  // Import the Home Page to navigate after successful login

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false; // To show loading indicator while logging in

  Future<void> login(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    // Check if email or password is empty
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter both email and password")),
      );
      return;
    }

    setState(() {
      isLoading = true; // Start loading
    });

    final url = Uri.parse('http://127.0.0.1:8000/api/login'); // Replace with your Laravel API URL
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    setState(() {
      isLoading = false; // Stop loading after response
    });

    if (response.statusCode == 200) {
  final data = json.decode(response.body);

  if (data['success']) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login Successful")),
    );

    // Navigate to the home page after successful login
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()), 
    );
  }
} else if (response.statusCode == 401) {
  // Handle 401 Unauthorized (invalid credentials)
  final data = json.decode(response.body);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(data['message'] ?? "Invalid credentials")),
  );
} else {
  // Handle other server errors
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Server Error: ${response.statusCode}")),
  );
}

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.emoji_events,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'Football League Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 30),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email, color: Colors.teal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock, color: Colors.teal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 30),
              isLoading
                  ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        login(context); // Call login function
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.teal,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpPage()), // Navigate to SignUp Page
                  );
                },
                child: Text(
                  'Don\'t have an account? Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
