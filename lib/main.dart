import 'package:flutter/material.dart';
import 'screens/homescreen.dart';

void main() {
  runApp(FireEvacuationApp());
}

class FireEvacuationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Fire Evacuation',
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomeScreen(),
    );
  }
}
