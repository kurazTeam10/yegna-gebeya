import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/core/locator.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/cubits/product_cubit/product_cubit.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/widgets/product_card.dart';
import 'package:go_router/go_router.dart';
import 'package:yegna_gebeya/core/router/routes.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';
import 'package:yegna_gebeya/shared/domain/models/user.dart' as user_model;

class ProductPage extends StatefulWidget {
  final user_model.User currentUser;
  const ProductPage({super.key, required this.currentUser});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Product> products = [];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8FF),
      appBar: AppBar(title: Text("My Product"), centerTitle: true),
      body: BlocBuilder<SellerProductCubit, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadingSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<SellerProductCubit>().loadSellerProducts(
                  sellerId: getIt<FirebaseAuth>().currentUser!.uid,
                );
              },
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.08,
                ),
                itemCount: state.products!.length,
                itemBuilder: (context, index) {
                  final product = state.products![index];
                  return ProductCard(
                    product: product,
                    user: widget.currentUser,
                  );
                },
              ),
            );
          } else if (state is ProductLoading) {
            return Center(
              child: SizedBox(
                height: height * 0.04,
                width: height * 0.04,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is ProductLoadingFailure) {
            return Center(child: Text('Error!'));
          } else {
            context.read<SellerProductCubit>().loadSellerProducts(
              sellerId: getIt<FirebaseAuth>().currentUser!.uid,
            );
            return SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(
            Routes.productUpload,
            extra: {"user": widget.currentUser, "product": null},
          );
        },
        backgroundColor: const Color(0xFF433CFF),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 2) {
            context.go(Routes.orders, extra: widget.currentUser);
          } else if (index == 1) {
            context.go(Routes.profile, extra: widget.currentUser);
          } else if (index == 0) {}
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Orders'),
        ],
      ),
    );
  }
}
