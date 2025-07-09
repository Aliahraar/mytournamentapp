import 'package:flutter/material.dart';
import 'dart:async';
import 'login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Start a timer for 4 seconds
    Timer(Duration(seconds: 4), () {
      // Navigate to the login page after 4 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
      body: Center(
          
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
                'Football League Tournament',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

            ],
        ),
      ),
    );
  }
}
