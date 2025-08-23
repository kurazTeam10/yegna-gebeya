import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/order.dart';
import '../cubit/orders_cubit.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;

  const OrderItem({super.key, required this.order});

  String getFormattedDate() {
    final now = DateTime.now();
    if (order.date.day == now.day &&
        order.date.month == now.month &&
        order.date.year == now.year) {
      return "Today";
    } else if (order.date.day == now.day - 1 &&
        order.date.month == now.month &&
        order.date.year == now.year) {
      return "Yesterday";
    } else {
      return "${order.date.day}-${order.date.month}-${order.date.year}";
    }
  }

  Color getStatusColor(String status) {
    return status == "pending"
        ? Colors.yellow.shade300
        : Colors.purple.shade300;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                order.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.productName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    getFormattedDate(),
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),
            ),

            // 🔹 Status Dropdown
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: getStatusColor(order.status),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: order.status,
                  dropdownColor: Colors.white,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 13,
                  ),
                  items: const [
                    DropdownMenuItem(value: "pending", child: Text("Pending")),
                    DropdownMenuItem(
                      value: "delivered",
                      child: Text("Delivered"),
                    ),
                  ],
                  onChanged: (newStatus) {
                    if (newStatus != null) {
                      context.read<OrderCubit>().updateOrderStatus(
                        order.id,
                        newStatus,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
