import 'package:flutter/material.dart';
import 'package:yegna_gebeya/core/locator.dart';
import 'package:yegna_gebeya/features/landing/presentation/pages/landing_page.dart';

void main() {
  setupLocator(); // Initialize dependency injection
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yegna Gebeya',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingPage(), // Set landing page as home
    );
  }
}