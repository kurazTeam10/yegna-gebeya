import 'package:yegna_gebeya/features/buyer/cart/domain/models/cart.dart';
import 'package:yegna_gebeya/shared/order/domain/models/order.dart';

abstract class CartRepository {
  Future<void> addToCart(String id, Order order);
  Future<void> removeFromCart(String id, Order order);
  Stream<Cart> getCartProducts(String id);
  Future<void> clearCart(String id);
}
