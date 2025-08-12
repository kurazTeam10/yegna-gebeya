class Order {
  final String id;
  final String sellerId;
  final List<String> productList;
  final String buyerId;
  final DateTime orderDate;
  bool isDelivered;

  Order({
    required this.id,
    required this.sellerId,
    required this.productList,
    required this.buyerId,
    required this.orderDate,
    this.isDelivered = false,
  });
}
