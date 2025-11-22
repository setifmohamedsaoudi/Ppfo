import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const PPFOMathApp());
}

class PPFOMathApp extends StatelessWidget {
  const PPFOMathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPFO v25.0 - نظام رياضي متكامل',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
