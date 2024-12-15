import 'package:flutter/material.dart';
import '../services/api_services.dart';

class JokeListScreen extends StatefulWidget {
  final String jokeType;

  JokeListScreen({required this.jokeType});

  @override
  _JokeListScreenState createState() => _JokeListScreenState();
}

class _JokeListScreenState extends State<JokeListScreen> {
  List<Map<String, dynamic>>? jokes;

  @override
  void initState() {
    super.initState();
    fetchJokes();
  }

  void fetchJokes() async {
    final jokeData = await ApiService.getJokesByType(widget.jokeType);
    setState(() {
      jokes = jokeData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.jokeType} Jokes"),
      ),
      body: jokes == null
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        padding: EdgeInsets.all(10),
        itemCount: jokes!.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.lightBlue[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jokes![index]['setup'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 15),
                  // Removed the 'Punchline:' label
                  Text(
                    jokes![index]['punchline'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
