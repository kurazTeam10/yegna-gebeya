import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/features/seller/order/presentation/cubit/orders_cubit.dart';
import 'package:yegna_gebeya/shared/order/domain/models/order.dart';

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
    return Container(
      height: height * 0.16,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.grey.shade50,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      order.product.imgUrl!,
                      height: height * 0.1,
                      width: width * 0.2,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: height * 0.1,
                          width: width * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey.shade400,
                            size: 24,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(width: width * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order.product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xFF2D2D2D),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: height * 0.008),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          SizedBox(width: 4),
                          Text(
                            getFormattedDate(),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.008),
                      Text(
                        "ETB ${order.product.price.toString()}",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Color(0xFF433CFF),
                        ),
                      ),
                    ],
                  ),
                ),

                // 🔹 Status Dropdown
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: getStatusColor(order.status.name),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: order.status.name == "pending" 
                          ? Colors.orange.shade200 
                          : Colors.green.shade200,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: getStatusColor(order.status.name).withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: height * 0.04,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: order.status.name,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: order.status.name == "pending" 
                              ? Colors.orange.shade800 
                              : Colors.green.shade800,
                          fontSize: 13,
                        ),
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: order.status.name == "pending" 
                              ? Colors.orange.shade800 
                              : Colors.green.shade800,
                          size: 20,
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
      ),
    );
  }
}
