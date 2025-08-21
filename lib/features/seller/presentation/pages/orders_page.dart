// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../domain_layer/models/order.dart';
// import '../widgets/order_item.dart';


// class OrderPage extends StatelessWidget {
//   const OrderPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => OrderCubit()..fetchOrders(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text("Seller Orders")),
//         body: Column(
//           children: [
//             // 🔹 Filter Buttons
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: BlocBuilder<OrderCubit, OrderState>(
//                 builder: (context, state) {
//                   return Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       buildFilterButton(context, "all"),
//                       buildFilterButton(context, "pending"),
//                       buildFilterButton(context, "delivered"),
//                     ],
//                   );
//                 },
//               ),
//             ),

//             // 🔹 Orders List
//             Expanded(
//               child: BlocBuilder<OrderCubit, OrderState>(
//                 builder: (context, state) {
//                   if (state is OrderLoading) {
//                     return const Center(
//                         child: CircularProgressIndicator());
//                   } else if (state is OrderLoaded) {
//                     if (state.orders.isEmpty) {
//                       return const Center(child: Text("No orders"));
//                     }
//                     return ListView.builder(
//                       itemCount: state.orders.length,
//                       itemBuilder: (context, index) {
//                         return OrderItem(order: state.orders[index]);
//                       },
//                     );
//                   } else if (state is OrderError) {
//                     return Center(child: Text("Error: ${state.message}"));
//                   }
//                   return const SizedBox.shrink();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // 🔹 Filter Button
//   Widget buildFilterButton(BuildContext context, String label) {
//     return OutlinedButton(
//       onPressed: () =>
//           context.read<OrderCubit>().filterOrders(label),
//       child: Text(label),
//     );
//   }
// }
