import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MatchTablePage extends StatefulWidget {
  final int tournamentId;

  MatchTablePage({required this.tournamentId});

  @override
  _MatchTablePageState createState() => _MatchTablePageState();
}

class _MatchTablePageState extends State<MatchTablePage> {
  List<dynamic> matches = [];

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }

  // Fetch matches from the API for the selected tournament
  Future<void> _fetchMatches() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/tournaments/${widget.tournamentId}/matches'));

    if (response.statusCode == 200) {
      setState(() {
        matches = json.decode(response.body)['matches'];
      });
    } else {
      // Handle error
      print('Failed to load matches');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Match Table"),
       backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          return ListTile(
            title: Text("${match['team_one']} vs ${match['team_two']}"),
            subtitle: Text("Date: ${match['match_date']}"),
          );
        },
      ),
    );
  }
}
