// home.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yegna_gebeya/core/router/routes.dart';
import 'package:yegna_gebeya/features/buyer/presentation/cubit/product_cubit.dart';
import 'package:yegna_gebeya/features/buyer/presentation/widgets/category_button.dart';
import 'package:yegna_gebeya/features/buyer/presentation/widgets/product_card.dart';
import 'package:yegna_gebeya/features/buyer/presentation/widgets/search_bar.dart';
import 'package:yegna_gebeya/shared/domain/models/user.dart';

class Home extends StatefulWidget {
  final User user;
  const Home({required this.user, super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late User user;
  int _selectedIndex = 0;
  String selectedCategory = 'All';
  List<String> categories = ['All'];
final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    user = widget.user;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductCubit>().fetchCategories().then((_) {
        if (!mounted) return;
        context.read<ProductCubit>().fetchAllProducts();
      });
    });
  }
@override
void dispose() {
  searchController.dispose();
  super.dispose();
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
                    backgroundColor: Colors.grey[200],
                    backgroundImage:
                        (user.imgUrl != null && user.imgUrl!.isNotEmpty)
                        ? NetworkImage(user.imgUrl!)
                        : null,
                    child: (user.imgUrl == null || user.imgUrl!.isEmpty)
                        ? const Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 32,
                          )
                        : null,
                  ),
                  SizedBox(width: size.width * 0.024),
                Expanded(
  child: SearchBarWidget(
    controller: searchController,
    onChanged: (query) {
      context.read<ProductCubit>().filterProducts(
        query: query,
        category: selectedCategory,
      );
    },
  ),
)
                ],
              ),
            ),

            Container(
              width: double.infinity,
              height: size.height * 0.2,
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
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            child: Image.asset(
                              'assets/images/product_hero.png',
                              fit: BoxFit.contain,
                            ),
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

            BlocConsumer<ProductCubit, ProductState>(
              listener: (context, state) {
                if (state is CategoriesLoaded) {
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
                            context.read<ProductCubit>().filterProducts(
                              query: searchController.text, // keep current search
                              category: label,
                            );
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
                        final crossAxisCount = constraints.maxWidth > 600
                            ? 3
                            : 2;

                        return GridView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.04,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 160 / 250,
                              ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCard(product: product, onTap: () {});
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 3) {
            // TODO: Implement navigation for Sellers
          } else if (index == 2) {
            // TODO: Implement navigation for Orders
          } else if (index == 1) {
            context.go(Routes.profile, extra: user);
          } else if (index == 0) {
            // TODO: Implement navigation for Home
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Sellers'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Orders'),
        ],
      ),
    );
  }
}
