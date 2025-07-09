import 'package:flutter/material.dart';
import 'package:tournament/home.dart';
import 'package:tournament/profile.dart';
import 'package:tournament/tournament.dart';
import 'dart:async';
import 'splashScreen.dart';
import 'dart:math';


void main() {
  
  runApp( const MyApp() );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
    );
  }
}



class MyHomePage extends StatefulWidget {
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>with SingleTickerProviderStateMixin {
 

  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          toolbarHeight: 0, // Remove AppBar title space
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50), // Compact height for TabBar
            child: TabBar(
              indicatorColor: Colors.white,
              indicatorWeight: 2,
              labelPadding: EdgeInsets.zero, // Remove extra padding
              tabs: [
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home, size: 18), // Small icon
                      Text("Home", style: TextStyle(fontSize: 10)), // Small text
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.emoji_events, size: 18), // Small icon
                      Text("tournament", style: TextStyle(fontSize: 10)), // Small text
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, size: 18), // Small icon
                      Text("Profile", style: TextStyle(fontSize: 10)), // Small text
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
              HomePage(),
              TournamentTab(),
              ProfilePage(),
          ],
        ),
      ),
    );
  }
 
}
