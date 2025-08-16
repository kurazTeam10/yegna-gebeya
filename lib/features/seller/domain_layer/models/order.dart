import 'product.dart';

class Order {
  final String id;
  final String buyerId;
  final DateTime orderDate;
  final List<Product> productList;
  bool isDelivered;

  Order({
    required this.id,
    required this.buyerId,
    required this.orderDate,
    required this.productList,
    this.isDelivered = false,
  });
}
