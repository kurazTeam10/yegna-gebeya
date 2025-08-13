
class Order {
  final String id;
  final String productId;
  final String buyerId;
  final DateTime orderDate;
  bool isDelivered;

  Order({
    required this.id,
    required this.productId,
    required this.buyerId,
    required this.orderDate,
    this.isDelivered = false,
  });
}
