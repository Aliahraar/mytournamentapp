import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'matchtable.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> tournaments = [];

  @override
  void initState() {
    super.initState();
    _fetchTournaments();
  }

  // Fetch tournaments from the API
  Future<void> _fetchTournaments() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/tournaments'));

    if (response.statusCode == 200) {
      setState(() {
        tournaments = json.decode(response.body);
      });
    } else {
      // Handle error
      print('Failed to load tournaments');
    }
  }

  // Delete tournament from the API
  Future<void> _deleteTournament(int id) async {
   
    final response = await http.delete(Uri.parse('http://127.0.0.1:8000/api/tournaments/$id'));
   
   
    if (response.statusCode == 200) {
      // Remove the deleted tournament from the local list
      setState(() {
        tournaments.removeWhere((tournament) => tournament['id'] == id);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tournament deleted successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete tournament'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: tournaments.length,
        itemBuilder: (context, index) {
          final tournament = tournaments[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.teal[50], // Light teal background for the card
              elevation: 5,
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                title: Text(
                  tournament['name'],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800], // Darker teal for the text
                  ),
                ),
                subtitle: Text(
                  'Tap to view matches',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.teal[600], // Lighter teal for subtitle
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Confirm deletion
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Confirm Delete'),
                        content: Text('Are you sure you want to delete this tournament?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              _deleteTournament(tournament['id']);
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                onTap: () {
                  // Navigate to the match table page with the tournament ID
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MatchTablePage(tournamentId: tournament['id']),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
