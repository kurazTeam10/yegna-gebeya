import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const purpleColor = Color(0xFF8D00DE);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
         
              SizedBox(
                width: 181,
                height: 177,
                child: Image.asset(
                  'assets/images/logo.jpg',
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),

  
              SizedBox(
                width: 331,
                height: 81,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                      Text(
                        'Yegna Gebeya',
                        style: TextStyle(
                          fontFamily: 'Robots',         
                          fontWeight: FontWeight.w700,  
                          fontSize: 28,                  
                          height: 1.0,                   
                          color: Color(0xFF8D00DE),      
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

      
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
                width: 329,
                height: 66,
                child: ElevatedButton(
                  onPressed: () {
                
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purpleColor,
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
                width: 329,
                height: 66,
                child: OutlinedButton(
                  onPressed: () {
             
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: const Color.fromARGB(255, 246, 245, 247), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(fontSize: 18, color: purpleColor),
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
