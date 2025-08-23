import 'package:yegna_gebeya/features/seller/order/domain/models/order.dart';

abstract class OrderRepository {
  Future<List<OrderModel>> getOrders();
  Future<void> addOrder(OrderModel order);
  Future<void> updateOrderStatus(String orderId, String status);
}
