import 'package:yegna_gebeya/shared/order/domain/models/order.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrders(String userId);
  Future<void> addOrder(Order order);
  Future<void> updateOrderStatus(String orderId, OrderStatus status);
}
