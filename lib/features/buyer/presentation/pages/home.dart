import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yegna_gebeya/features/buyer/presentation/widgets/category_button.dart';
import 'package:yegna_gebeya/features/buyer/presentation/widgets/product_card.dart';
import 'package:yegna_gebeya/features/buyer/presentation/widgets/search_bar.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedCategory = 'All';

  final categories = [
    'All',
    'Electronic',
    'cloth',
    'furniture',
    'cosmetics',
    'shoes',
    'machine',
  ];

  final List<Product> products = [
    Product(
      productId: '1',
      productName: 'Wireless Headphones',
      productImageUrl: 'assets/images/Rectangle 11 (1).png',
      productDescription: 'High-quality wireless headphones',
      price: 1250.0,
      sellerId: 'seller1',
      category: ProductCategory.technology,
    ),
    Product(
      productId: '2',
      productName: 'T-shirt',
      productImageUrl: 'assets/images/Rectangle 11 (1).png',
      productDescription: 'Latest smartwatch with advanced features',
      price: 3499.0,
      sellerId: 'seller2',
      category: ProductCategory.technology,
    ),
    Product(
      productId: '3',
      productName: 'Leather Jacket',
      productImageUrl: 'assets/images/Rectangle 11 (2).png',
      productDescription: 'Genuine leather jacket',
      price: 2800.0,
      sellerId: 'seller3',
      category: ProductCategory.clothes,
    ),
    Product(
      productId: '4',
      productName: 'Running Shoes',
      productImageUrl: 'assets/images/Rectangle 11 (3).png',
      productDescription: 'Comfortable running shoes',
      price: 1899.0,
      sellerId: 'seller4',
      category: ProductCategory.others,
    ),
    Product(
      productId: '5',
      productName: 'Perfume Collection',
      productImageUrl: 'assets/images/Rectangle 11 (1).png',
      productDescription: 'Luxury perfume collection',
      price: 1500.0,
      sellerId: 'seller5',
      category: ProductCategory.others,
    ),
    Product(
      productId: '6',
      productName: 'Coffee Table',
      productImageUrl: 'assets/images/Rectangle 11 (1).png',
      productDescription: 'Modern coffee table',
      price: 4200.0,
      sellerId: 'seller6',
      category: ProductCategory.furniture,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  CircleAvatar(
                    radius: size.width * 0.06,
                    backgroundImage: const AssetImage('assets/images/Ellipse 7.png'),
                  ),
                  SizedBox(width: size.width * 0.024),
                  const Expanded(child: SearchBarWidget()),
                ],
              ),
            ),

      
            Container(
              width: double.infinity,
              height: size.height * 0.25, 
              margin: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.02,
              ),
              decoration: BoxDecoration(
                color: purpleColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
             
                  if (constraints.maxWidth > 600) {
              
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Explore new\nCollections",
                                  style: GoogleFonts.sarpanch(
                                    fontSize: constraints.maxWidth * 0.03,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: constraints.maxHeight * 0.05),
                                Container(
                                  width: constraints.maxWidth * 0.3,
                                  height: constraints.maxHeight * 0.25,
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
                                      fontSize: constraints.maxWidth * 0.015,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Image.asset(
                            'assets/images/product_hero.png',
                            height: constraints.maxHeight * 0.8,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    );
                  } else {
                
                    return Stack(
                      children: [
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Image.asset(
                            'assets/images/product_hero.png',
                            height: constraints.maxHeight * 0.8,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Explore new\nCollections",
                                style: GoogleFonts.sarpanch(
                                  fontSize: constraints.maxWidth * 0.06,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                width: constraints.maxWidth * 0.4,
                                height: constraints.maxHeight * 0.2,
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
                                    fontSize: constraints.maxWidth * 0.035,
                                  ),
                                ),
                              ),
                              SizedBox(height: constraints.maxHeight * 0.05),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),


            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: Row(
                children: categories.map((label) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CategoryButton(
                      label: label,
                      isSelected: selectedCategory == label,
                      onPressed: () {
                        setState(() {
                          selectedCategory = label;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            SizedBox(height: size.height * 0.02),

     
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
          
                  final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                  
                  return GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 160 / 250,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        onTap: () {
                          
                        },
                      );
                    },
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