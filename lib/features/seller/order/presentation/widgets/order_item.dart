import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/order.dart';
import '../cubit/orders_cubit.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  const OrderItem({super.key, required this.order});

  String getFormattedDate() {
    final now = DateTime.now();
    if (order.orderDate.day == now.day &&
        order.orderDate.month == now.month &&
        order.orderDate.year == now.year) {
      return "Today";
    } else if (order.orderDate.day == now.day - 1 &&
        order.orderDate.month == now.month &&
        order.orderDate.year == now.year) {
      return "Yesterday";
    } else {
      return "${order.orderDate.day}-${order.orderDate.month}-${order.orderDate.year}";
    }
  }

  Color getStatusColor(String status) {
    return status == "pending"
        ? Colors.yellow.shade300
        : Colors.purple.shade300;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: height * 0.15,
      child: Card(
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
                  order.product.imgUrl!,
                  width: width * 0.25,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: width * 0.02),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                    Text(
                      getFormattedDate(),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),

              // 🔹 Status Dropdown
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: getStatusColor(order.status.name),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: height * 0.04,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: order.status.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                        fontSize: 13,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: "pending",
                          child: Text("Pending"),
                        ),
                        DropdownMenuItem(
                          value: "delivered",
                          child: Text("Delivered"),
                        ),
                      ],
                      onChanged: (newStatus) {
                        if (newStatus != null) {
                          context.read<OrderCubit>().updateOrderStatus(
                            order.id,
                            newStatus == "pending"
                                ? OrderStatus.pending
                                : OrderStatus.delivered,
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
