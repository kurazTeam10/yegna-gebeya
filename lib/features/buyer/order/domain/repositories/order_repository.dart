import 'package:yegna_gebeya/features/buyer/order/domain/models/order.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrders(String id);
  Future<void> cancelOrder(String orderId);
  Future<void> purchaseProduct(String id);
}
