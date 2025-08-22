// home.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yegna_gebeya/features/buyer/presentation/cubit/product_cubit.dart';
import 'package:yegna_gebeya/features/buyer/presentation/widgets/category_button.dart';
import 'package:yegna_gebeya/features/buyer/presentation/widgets/product_card.dart';
import 'package:yegna_gebeya/features/buyer/presentation/widgets/search_bar.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedCategory = 'All';
  List<String> categories = ['All']; 

  
@override
void initState() {
  super.initState();
  
  // Fetch categories first, then products
  WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<ProductCubit>().fetchCategories().then((_) {
      context.read<ProductCubit>().fetchAllProducts();
    });
  });
}
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
        
            // In your Home build method, replace the BlocBuilder with:
        BlocConsumer<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is CategoriesLoaded) {
              // Update local categories when they are loaded
              setState(() {
                categories = state.categories;
              });
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
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
              if (label == 'All') {
                context.read<ProductCubit>().fetchAllProducts();
              } else {
                context.read<ProductCubit>().fetchProductsByCategory(label);
              }
            },
          ),
        );
                }).toList(),
              ),
            );
          },
        ),
        
            SizedBox(height: size.height * 0.02),
        
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductError) {
                    return Center(child: Text(state.message));
                  } else if (state is ProductLoaded) {
                    final products = state.products;
                    
                    if (products.isEmpty) {
                      return Center(
                        child: Text(
                          'No products found in $selectedCategory category',
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }
                    
                    return LayoutBuilder(
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
                    );
                  } else {
                    return const Center(child: Text('No products available'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}