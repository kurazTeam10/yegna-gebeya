import 'package:yegna_gebeya/features/buyer/cart/domain/models/cart.dart';
import 'package:yegna_gebeya/shared/models/product.dart';

abstract class CartRepository {
  Future<void> addToCart(String id, Product product);
  Future<void> removeFromCart(String id, Product product);
  Stream<Cart> getCartProducts(String id);
  Future<void> clearCart(String id);
}
