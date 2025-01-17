import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> result;

  ResultScreen({required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Location: ${result['user_location']}'),
            SizedBox(height: 8),
            Text('Shortest Path: ${result['shortest_path'].join(' -> ')}'),
            SizedBox(height: 8),
            Text('Total Distance: ${result['total_distance']}'),
          ],
        ),
      ),
    );
  }
}
