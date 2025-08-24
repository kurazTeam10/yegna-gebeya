import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/core/locator.dart';
import 'package:yegna_gebeya/core/router/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:yegna_gebeya/features/seller/order/presentation/cubit/orders_cubit.dart';
import 'package:yegna_gebeya/features/seller/order/presentation/cubit/orders_state.dart';
import 'package:yegna_gebeya/features/seller/order/presentation/widgets/order_item.dart';
import 'package:yegna_gebeya/shared/domain/models/user.dart';
import 'package:yegna_gebeya/shared/order/domain/repositories/order_repository.dart';

class OrderPage extends StatefulWidget {
  final User currentUser;
  const OrderPage({super.key, required this.currentUser});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderCubit(orderRepository: getIt<OrderRepository>())
            ..fetchOrders(widget.currentUser.id),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Orders",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: BlocBuilder<OrderCubit, OrderLoadingState>(
                builder: (context, state) {
                  String activeFilter = "all"; // Default value
                  List allOrders = [];
                  List pendingOrders = [];
                  List deliveredOrders = [];
                  if (state is OrderLoadingSuccess) {
                    activeFilter = state.activeFilter; // Use state.activeFilter
                    allOrders = state.orders;
                    pendingOrders = state.orders
                        .where((o) => o.status.name == 'pending')
                        .toList();
                    deliveredOrders = state.orders
                        .where((o) => o.status.name == 'delivered')
                        .toList();
                  }

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildFilterButton(
                        context,
                        "all",
                        allOrders,
                        activeFilter,
                      ),
                      buildFilterButton(
                        context,
                        "pending",
                        pendingOrders,
                        activeFilter,
                      ),
                      buildFilterButton(
                        context,
                        "delivered",
                        deliveredOrders,
                        activeFilter,
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<OrderCubit, OrderLoadingState>(
                builder: (context, state) {
                  if (state is OrderLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is OrderLoadingSuccess) {
                    final filteredOrders = state.filteredOrders;
                    if (filteredOrders.isEmpty) {
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
                      itemCount: filteredOrders.length,
                      itemBuilder: (context, index) {
                        return OrderItem(order: filteredOrders[index]);
                      },
                    );
                  } else if (state is OrderLoadingFailure) {
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            if (index == 2) {
            } else if (index == 1) {
              context.go(Routes.sellerProfile, extra: widget.currentUser);
            } else if (index == 0) {
              context.go(Routes.products, extra: widget.currentUser);
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag),
              label: 'Products',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Orders',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterButton(
    BuildContext context,
    String label,
    List orders,
    String active,
  ) {
    final bool isActive = label.toLowerCase() == active.toLowerCase();
    final primary = Theme.of(context).colorScheme.primary;

    // Debug print to verify values
    print('label: $label, active: $active, isActive: $isActive');

    return OutlinedButton(
      onPressed: () => context.read<OrderCubit>().filterOrders(label),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          isActive ? primary : Colors.white,
        ),
        foregroundColor: WidgetStateProperty.all(
          isActive ? Colors.white : Colors.black,
        ),
        side: WidgetStateProperty.all(
          BorderSide(color: isActive ? primary : Colors.purple, width: 2),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
      ),
      child: Text(
        '${label.toUpperCase()} (${orders.length})',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}
