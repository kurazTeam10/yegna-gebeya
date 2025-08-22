import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain_layer/models/order.dart';
import '../widgets/order_item.dart';
import '../cubit/orders_cubit.dart';
import '../cubit/orders_state.dart';
// import '../pages/seller_home_page.dart'; 

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderCubit(FirebaseFirestore.instance)..fetchOrders(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Buyer Orders",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              // Navigate to Seller Home
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (_) => const SellerHomePage()),
              // );
            },
          ),
          elevation: 1,
        ),
        body: Column(
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) {
                  String activeFilter = "all";
                  if (state is OrderLoaded) {
                    activeFilter = state.selectedFilter;
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildFilterButton(context, "all", activeFilter),
                      buildFilterButton(context, "pending", activeFilter),
                      buildFilterButton(context, "delivered", activeFilter),
                    ],
                  );
                },
              ),
            ),

            Expanded(
              child: BlocBuilder<OrderCubit, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is OrderLoaded) {
                    if (state.orders.isEmpty) {
                      return const Center(
                        child: Text(
                          "No orders yet",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: state.orders.length,
                      itemBuilder: (context, index) {
                        return OrderItem(order: state.orders[index]);
                      },
                    );
                  } else if (state is OrderError) {
                    return Center(
                      child: Text(
                        "Error: ${state.message}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
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

  Widget buildFilterButton(BuildContext context, String label, String active) {
    final bool isActive = label == active;

    return OutlinedButton(
      onPressed: () => context.read<OrderCubit>().filterOrders(label),
      style: OutlinedButton.styleFrom(
        backgroundColor: isActive ?  Theme.of(context).colorScheme.primary : Colors.white,
        side: const BorderSide(color: Colors.purple, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isActive ? Colors.white : Colors.black,
          fontSize: 14,
        ),
      ),
    );
  }
}
