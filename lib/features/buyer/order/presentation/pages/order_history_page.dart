import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:yegna_gebeya/features/buyer/order/presentation/bloc/order_bloc/order_bloc.dart';

import '../widgets/single_order_widget.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrderBloc>().add(
      GetOrderHistory(id: context.read<SignInCubit>().state.cred!.user!.uid),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            tabs: [
              Tab(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFF8D00DE), width: 1),
                  ),
                  child: Align(alignment: Alignment.center, child: Text('all')),
                ),
              ),
              Tab(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFF8D00DE), width: 1),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('pending'),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFF8D00DE), width: 1),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('delivered'),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFF8D00DE), width: 1),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('canceled'),
                  ),
                ),
              ),
            ],
            indicator: BoxDecoration(
              border: Border.all(width: 2, color: Color(0xFF8D00DE)),
              color: Color(0xFF8D00DE),
              borderRadius: BorderRadius.circular(10),
            ),
            dividerHeight: 0,
            labelColor: Colors.white,
            unselectedLabelColor: Color(0xFF8D00DE),
            labelPadding: EdgeInsets.zero,
            indicatorSize: TabBarIndicatorSize.label,
          ),
        ),
        body: TabBarView(
          children: [
            _buildTabContent(context, 'all'),
            _buildTabContent(context, false),
            _buildTabContent(context, true),
            _buildTabContent(context, null),
          ],
        ),
      ),
    );
  }

  BlocConsumer<OrderBloc, OrderState> _buildTabContent(
    BuildContext context,
    dynamic filter,
  ) {
    return BlocConsumer<OrderBloc, OrderState>(
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
                    context.read<OrderBloc>().add(
                      GetOrderHistory(
                        id: context.read<SignInCubit>().state.cred!.user!.uid,
                      ),
                    );
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (state is OrderLoaded) {
          var orders = state.orders;

          if (filter is bool?) {
            orders = orders.where((o) => o.isDelivered == filter).toList();
          }

          if (orders.isEmpty) {
            return const Center(child: Text('You have no orders yet'));
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) => Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SingleOrderWidget(order: orders[index]),
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
