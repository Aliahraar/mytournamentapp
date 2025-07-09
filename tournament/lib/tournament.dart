import 'package:flutter/material.dart';
import 'dart:math'; // For random pairing
import 'package:http/http.dart' as http; // For API call
import 'dart:convert'; // For JSON encoding

class TournamentTab extends StatelessWidget {
  final List<String> teamNames = [];
  String tournamentName = ""; // Store the tournament name

  void _showModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Tournament Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Tournament Name Input Field
              TextField(
                decoration: InputDecoration(
                  labelText: "Tournament Name",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  tournamentName = value; // Save the tournament name
                },
              ),
              SizedBox(height: 20),
              ...[4, 6, 8, 12].map((number) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showTextFields(context, number);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      "$number ",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _showTextFields(BuildContext context, int count) {
    teamNames.clear(); // Clear any previous entries

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Enter Team Names"),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: List.generate(count, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: "Team ${index + 1}",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (teamNames.length > index) {
                          teamNames[index] = value; // Update name
                        } else {
                          teamNames.add(value); // Add name
                        }
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _performLotteryAndSend(context);
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  void _performLotteryAndSend(BuildContext context) {
    if (teamNames.length % 2 != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter an even number of teams.")),
      );
      return;
    }

    if (tournamentName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tournament name cannot be empty.")),
      );
      return;
    }

    // Shuffle and pair the teams
    teamNames.shuffle(Random());
    List<Map<String, String>> pairs = [];
    for (int i = 0; i < teamNames.length; i += 2) {
      pairs.add({
        "team1": teamNames[i],
        "team2": teamNames[i + 1],
      });
    }

    // Display pairs (optional)
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Match Pairs"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: pairs.map((pair) {
              return Text("${pair['team1']} vs ${pair['team2']}");
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _sendResultsToApi(context, pairs);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _sendResultsToApi(BuildContext context, List<Map<String, String>> pairs) async {
    final url = Uri.parse("http://127.0.0.1:8000/api/matches");
    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "tournament_name": tournamentName,
          "matches": pairs,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Results sent successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send results.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }







  

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
  children: [
      const  Icon(
                Icons.emoji_events,
                size: 100,
                color: Colors.teal,
              ),
    Padding(
      padding: const EdgeInsets.all(17.0),
      child: Text(
        'Welcome to the Tournament App!',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.teal[800],
        ),
        textAlign: TextAlign.center,
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Text(
        'Select a tournament below to view the matchups between teams. You can choose the number of teams and proceed with the lottery to generate the match schedule.',
        style: TextStyle(
          fontSize: 16,
          color: Colors.teal[600],
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    ),
    SizedBox(height: 20),
    ElevatedButton(
      onPressed: () {
        _showModal(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text("Create Tournament "),
    ),
  ],
),

    );
  }
}
