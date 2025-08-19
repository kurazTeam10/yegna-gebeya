import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // For custom fonts

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final avatarSize = size.width * 0.12;
    final purpleColor = const Color(0xFF8D00DE);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
             Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.02,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: purpleColor,
                        width: size.width * 0.003,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: size.width * 0.06,
                      backgroundImage: const AssetImage('assets/images/Ellipse 7.png'),
                    ),
                  ),
                  SizedBox(width: size.width * 0.024),
                  Expanded(
                    child: Container(
                      height: size.height * 0.065,
                      padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: size.width * 0.003,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search products',
                          border: InputBorder.none,
                          icon: Icon(Icons.search, color: Color(0xFF8D00DE)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.25,
              decoration: BoxDecoration(
                color: purpleColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.all(16),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: constraints.maxWidth * 0.45,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Explore new',
                                  style: GoogleFonts.sarpanch(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Collections',
                                  style: GoogleFonts.sarpanch(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: constraints.maxWidth * 0.4,
                              height: size.height * 0.05,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'Explore Now',
                                style: GoogleFonts.sail(
                                  fontWeight: FontWeight.bold,
                                  color: purpleColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: constraints.maxWidth * 0.45,
                        height: size.height * 0.19,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/product_hero.png'),
                            fit: BoxFit.contain,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}