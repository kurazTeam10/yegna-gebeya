import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/features/buyer/presentation/bloc/sellerList/seller_list_bloc.dart';
import 'package:yegna_gebeya/features/buyer/presentation/bloc/sellerList/seller_list_event.dart';
import 'package:yegna_gebeya/features/buyer/presentation/bloc/sellerList/seller_list_state.dart';
import 'package:yegna_gebeya/features/buyer/presentation/widgets/search_bar.dart';
import 'package:yegna_gebeya/features/buyer/presentation/widgets/seller_card.dart';

class SellerListPage extends StatefulWidget {
  const SellerListPage({super.key});

  @override
  State<SellerListPage> createState() => _SellerListPageState();
}

class _SellerListPageState extends State<SellerListPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SellerListBloc>().add(FetchSellersEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF8D00DE),
        unselectedItemColor: Colors.grey,
        currentIndex: 2, // Sellers tab is active
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Sellers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              GoRouter.of(context).go('/');
              break;
            case 1:
              // TODO: Navigate to Profile page
              break;
            case 2:
              GoRouter.of(context).go('/');
              break;
            case 3:
              // TODO: Navigate to Orders page
              break;
          }
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            SearchBarWidget(
              controller: _searchController,
              hintText: 'Search by name, phone or product...',
              margin: EdgeInsets.only(
                top: screenHeight * 0.08, // Move up slightly
                left: screenWidth * 0.065, // Responsive left margin
                right: screenWidth * 0.065, // Responsive right margin
              ),
              onChanged: (query) {
                if (query.isEmpty) {
                  context.read<SellerListBloc>().add(FetchSellersEvent());
                } else {
                  context.read<SellerListBloc>().add(SearchSellersEvent(query));
                }
              },
            ),

            // Space between search bar and first card
            SizedBox(height: screenHeight * 0.03),

            // Sellers List
            Expanded(
              child: BlocConsumer<SellerListBloc, SellerListState>(
                listener: (context, state) {
                  if (state is SellerListError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${state.message}'),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is SellerListInitial) {
                    return const Center(
                      child: Text(
                        'Loading sellers...',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }

                  if (state is SellerListLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFF8B5CF6),
                        ),
                      ),
                    );
                  }

                  if (state is SellerListLoaded) {
                    if (state.sellers.isEmpty) {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.store_outlined,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No sellers found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.065),
                      itemCount: state.sellers.length,
                      itemBuilder: (context, index) {
                        final seller = state.sellers[index];
                        return SellerCard(seller: seller);
                      },
                    );
                  }

                  if (state is SellerListError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 64,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error: ${state.message}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<SellerListBloc>()
                                  .add(FetchSellersEvent());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8B5CF6),
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
