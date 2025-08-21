import 'package:flutter/material.dart';
import '../../domain_layer/models/order.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  const OrderItem({super.key, required this.order});

  String getFormattedDate() {
    final now = DateTime.now();
    if (order.date.day == now.day &&
        order.date.month == now.month &&
        order.date.year == now.year) {
      return "today";
    } else if (order.date.day == now.day - 1 &&
        order.date.month == now.month &&
        order.date.year == now.year) {
      return "yesterday";
    } else {
      return "${order.date.day}-${order.date.month}-${order.date.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      color: const Color.fromARGB(255, 181, 98, 194),
      child: ListTile(
        leading: Image.network(order.imageUrl, width: 50, height: 50),
        title: Text(order.productName),
        subtitle: Text(getFormattedDate()),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: order.status == "pending"
                ? Colors.yellow.shade200
                : Colors.green.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            order.status,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
