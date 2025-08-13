import 'product_entity.dart';

class OrderEntity {
  final String id;
  final String buyerId;
  final String sellerId;
  final List<ProductEntity> items;
  final double totalAmount;
  final String status;
  final DateTime createdAt;

  const OrderEntity({
    required this.id,
    required this.buyerId,
    required this.sellerId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
  });
}
