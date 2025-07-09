import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = true;
  Map<String, dynamic>? _userData;

  // Function to fetch user data from API
  Future<void> _fetchUserData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/profile'));

    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
        _userData = json.decode(response.body); // Assuming API returns JSON
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      // Handle error (e.g., show an error message)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user data')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data when the page loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner
          : Container(
              width: double.infinity, // Ensure full width
              height: double.infinity, // Ensure full height
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.green], // Use teal color gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Profile Picture
                      Container(
                        margin: EdgeInsets.only(top: 50),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: ClipOval(
                          child: _userData?['profile_picture'] != null
                              ? Image.network(
                                  _userData!['profile_picture'],
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                )
                              : Icon(
                                  Icons.person,
                                  size: 120,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      SizedBox(height: 30),
                      // User Name
                      Text(
                        _userData?['name'] ?? 'Name not available',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8),
                      // User Email
                      Text(
                        _userData?['email'] ?? 'Email not available',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 30),
                      // User Info Card
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.white.withOpacity(0.9),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'User Details',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal, // Teal color for title
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Phone:'),
                                  Text(
                                    _userData?['phone'] ?? 'Not available',
                                    style: TextStyle(
                                      color: Colors.teal, // Teal color for value
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Address:'),
                                  Text(
                                    _userData?['address'] ?? 'Not available',
                                    style: TextStyle(
                                      color: Colors.teal, // Teal color for value
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
