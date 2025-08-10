import 'package:yegna_gebeya/core/models/product.dart';
import 'package:yegna_gebeya/core/models/cart.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProductById(String productId);
}

abstract class CartRepository {
  Future<Cart> getCart(String userId);
  Future<void> addProductToCart(String userId, String productId, int quantity);
  Future<void> removeProductFromCart(String userId, String productId);
}

abstract class OrderRepository {
  Future<void> purchaseProducts(String userId, List<CartItem> items);
}
