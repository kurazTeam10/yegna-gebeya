import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Yegna Gebeya'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Your Marketplace App'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to sign up page
              },
              child: const Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to sign in page
              },
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}