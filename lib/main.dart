import 'package:flutter/material.dart';
import 'package:ppfo_math_app/screens/home_screen.dart';
import 'package:ppfo_math_app/screens/about_screen.dart';

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
        fontFamily: 'Tajawal',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 18),
        ),
      ),
      home: const HomeScreen(),
      routes: {
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
