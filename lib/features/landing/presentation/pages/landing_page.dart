import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yegna_gebeya/core/router/routes.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: width * 0.4,
                child: Image.asset(
                  'assets/images/logo.jpg',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: width * 0.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        fontSize: width * 0.06,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Text(
                      'Yegna Gebeya',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        fontSize: width * 0.07,
                        height: height * 0.001,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02),
              SizedBox(
                width: 328,
                height: 122,
                child: Text(
                  'Find great deals, trendy products, and fast, secure shopping — all in one app. Start your seamless shopping journey now!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF999999),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 40),
              SizedBox(
                width: width * 0.8,
                height: height * 0.075,
                child: ElevatedButton(
                  onPressed: () {
                    context.go(Routes.signUp);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: width * 0.8,
                height: height * 0.075,
                child: OutlinedButton(
                  onPressed: () {
                    context.go(Routes.signIn);
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withAlpha(13),
                      width: 2,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
