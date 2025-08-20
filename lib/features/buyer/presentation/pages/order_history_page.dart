import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yegna_gebeya/features/buyer/presentation/bloc/order_bloc/order_bloc.dart';

//TODO: add proper id from an auth cubit/bloc

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(GetOrderHistory(id: 'AfGvuQs8LDYbPUFKtdl4wkMo2Br2'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History'),),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (BuildContext context, OrderState state) {
          if (state is OrderError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is OrderLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OrderError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Failed to load orders: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<OrderBloc>().add(GetOrderHistory(id: 'AfGvuQs8LDYbPUFKtdl4wkMo2Br2'));
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is OrderLoaded) {
            final orders = state.orders;
            if (orders.isEmpty) {
              return const Center(child: Text('You have no orders yet'));
            }

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) => Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${orders[index].orderId ?? 'N/A'}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Date: ${DateFormat('MMM dd, yyyy').format(orders[index].orderDate)}',
                      ),
                      Text(
                        'Status: ${orders[index].isDelivered ? 'Delivered' : 'Not Delivered'}',
                      ),
                      Text(
                        'Total: \$${orders[index].productList.map((product) => product.price).toList().reduce((sum, cur) => sum + cur).toStringAsFixed(2)}',
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
