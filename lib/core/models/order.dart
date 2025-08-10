import 'product.dart';

class Order {
  final String orderId;
  final String userId;
  final double totalAmount;
  final DateTime orderDate;
  final List<OrderItem> items;

  const Order({
    required this.orderId,
    required this.userId,
    required this.totalAmount,
    required this.orderDate,
    required this.items,
  });
}

class OrderItem {
  final Product product;
  final int quantity;
  final double price; // Price at the time of purchase

  const OrderItem({
    required this.product,
    required this.quantity,
    required this.price,
  });
}
