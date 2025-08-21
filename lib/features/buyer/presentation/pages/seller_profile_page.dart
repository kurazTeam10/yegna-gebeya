import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yegna_gebeya/core/router/routes.dart';
import 'package:yegna_gebeya/features/buyer/presentation/bloc/sellerProfile/seller_profile_bloc.dart';
import 'package:yegna_gebeya/features/buyer/presentation/bloc/sellerProfile/seller_profile_event.dart';
import 'package:yegna_gebeya/features/buyer/presentation/bloc/sellerProfile/seller_profile_state.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';
import 'package:yegna_gebeya/features/buyer/presentation/widgets/product_card.dart';
import 'package:yegna_gebeya/features/buyer/presentation/widgets/category_chip.dart';
import 'package:yegna_gebeya/shared/presentation/widgets/custom_snackbar.dart';

class SellerProfilePage extends StatefulWidget {
  final String sellerId;

  const SellerProfilePage({super.key, required this.sellerId});

  @override
  State<SellerProfilePage> createState() => _SellerProfilePageState();
}

class _SellerProfilePageState extends State<SellerProfilePage> {
  final TextEditingController _searchController = TextEditingController();
  ProductCategory? _selectedCategory;

  @override
  void initState() {
    super.initState();
    context
        .read<SellerProfileBloc>()
        .add(FetchSellerProfileEvent(widget.sellerId));
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Product> _getFilteredProducts(List<Product> products) {
    List<Product> filtered = products;

    if (_selectedCategory != null) {
      filtered = filtered
          .where((product) => product.category == _selectedCategory)
          .toList();
    }

    final searchQuery = _searchController.text.toLowerCase();
    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((product) =>
              product.productName.toLowerCase().contains(searchQuery))
          .toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: BlocBuilder<SellerProfileBloc, SellerProfileState>(
          builder: (context, state) {
            if (state is SellerProfileLoading ||
                state is SellerProfileInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is SellerProfileError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    ElevatedButton(
                      onPressed: () {
                        context
                            .read<SellerProfileBloc>()
                            .add(FetchSellerProfileEvent(widget.sellerId));
                      },
                      child: const Text('Retry'),
                    )
                  ],
                ),
              );
            }
            if (state is SellerProfileLoaded) {
              final seller = state.seller;
              final products = state.products;
              return Stack(
                children: [
                  Column(
                    children: [
                      // Top Navigation with Back Button
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.04,
                          vertical: screenHeight * 0.02,
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                if (Navigator.of(context).canPop()) {
                                  Navigator.of(context).pop();
                                } else {
                                  context.go(Routes.sellerList);
                                }
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Color.fromARGB(255, 187, 182, 189),
                                size: 24,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Seller Header
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.065,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: screenWidth * 0.08,
                              backgroundColor:
                                  const Color.fromARGB(255, 173, 171, 177),
                              backgroundImage: seller.imgUrl.isNotEmpty
                                  ? NetworkImage(seller.imgUrl)
                                  : null,
                              child: seller.imgUrl.isEmpty
                                  ? Icon(
                                      Icons.person,
                                      size: screenWidth * 0.08,
                                      color: const Color.fromARGB(
                                          255, 153, 16, 180),
                                    )
                                  : null,
                            ),
                            SizedBox(width: screenWidth * 0.06),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    seller.fullName,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.045,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.005),
                                  Text(
                                    seller.phone,
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.035,
                                      color:
                                          const Color.fromARGB(255, 25, 22, 22),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.008),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),

                      // Product Search Bar
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.065,
                          vertical: screenHeight * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(
                            color: const Color(0xFFE1DBFF),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Search products...',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color.fromARGB(239, 157, 2, 247),
                              size: 24,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ),
                          ),
                          onChanged: (query) {
                            setState(() {});
                          },
                        ),
                      ),

                      // Category Filter Chips
                      Container(
                        height: screenHeight * 0.045,
                        margin: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06,
                        ),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            CategoryChip(
                              label: 'clothes',
                              isSelected:
                                  _selectedCategory == ProductCategory.clothes,
                              onTap: () {
                                setState(() {
                                  _selectedCategory = _selectedCategory ==
                                          ProductCategory.clothes
                                      ? null
                                      : ProductCategory.clothes;
                                });
                              },
                            ),
                            SizedBox(width: screenWidth * 0.035),
                            CategoryChip(
                              label: 'tech ',
                              isSelected: _selectedCategory ==
                                  ProductCategory.technology,
                              onTap: () {
                                setState(() {
                                  _selectedCategory = _selectedCategory ==
                                          ProductCategory.technology
                                      ? null
                                      : ProductCategory.technology;
                                });
                              },
                            ),
                            SizedBox(width: screenWidth * 0.035),
                            CategoryChip(
                              label: 'furniture',
                              isSelected: _selectedCategory ==
                                  ProductCategory.furniture,
                              onTap: () {
                                setState(() {
                                  _selectedCategory = _selectedCategory ==
                                          ProductCategory.furniture
                                      ? null
                                      : ProductCategory.furniture;
                                });
                              },
                            ),
                            SizedBox(width: screenWidth * 0.035),
                            CategoryChip(
                              label: 'jewellery',
                              isSelected: _selectedCategory ==
                                  ProductCategory.jewellery,
                              onTap: () {
                                setState(() {
                                  _selectedCategory = _selectedCategory ==
                                          ProductCategory.jewellery
                                      ? null
                                      : ProductCategory.jewellery;
                                });
                              },
                            ),
                            SizedBox(width: screenWidth * 0.035),
                            CategoryChip(
                              label: 'others',
                              isSelected:
                                  _selectedCategory == ProductCategory.others,
                              onTap: () {
                                setState(() {
                                  _selectedCategory = _selectedCategory ==
                                          ProductCategory.others
                                      ? null
                                      : ProductCategory.others;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),

                      // Products List
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.fromLTRB(
                              screenWidth * 0.065, 0, screenWidth * 0.065, 50),
                          itemCount: _getFilteredProducts(products).length,
                          itemBuilder: (context, index) {
                            final product =
                                _getFilteredProducts(products)[index];
                            return ProductCard(
                              product: product,
                              onAddToCart: () {
                                showCustomSnackBar(context,
                                    '${product.productName} added to cart');
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 30,
                    right: 30,
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: FloatingActionButton(
                        onPressed: () {
                          // Navigate to cart
                        },
                        backgroundColor: const Color(0xFF8D00DE),
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            const Icon(Icons.shopping_cart_checkout_outlined,
                                color: Colors.white, size: 32),
                            Positioned(
                              top: -4,
                              right: -4,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.white,
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                      )
                                    ]),
                                child: const Text(
                                  '2',
                                  style: TextStyle(
                                    color: Color(0xFF8D00DE),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                      ),
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
