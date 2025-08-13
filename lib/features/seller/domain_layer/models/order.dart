import 'product.dart';

class Order {
  final String id;
  final String sellerId;
  final String buyerId;
  final DateTime orderDate;
  final List<Product> productList;
  bool isDelivered;

  Order({
    required this.id,
    required this.sellerId,
    required this.buyerId,
    required this.orderDate,
    required this.productList,
    this.isDelivered = false,
  });
}
