import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/core/models/product.dart';
import 'package:yegna_gebeya/core/models/cart.dart';
import 'package:yegna_gebeya/core/models/seller.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts();
  Future<Product> getProductById(String productId);
  Future<Seller> getSeller(DocumentReference sellerRef);
}

abstract class CartRepository {
  Future<Cart> getCart(String userId);
  Future<void> addProductToCart(String userId, String productId, int quantity);
  Future<void> removeProductFromCart(String userId, String productId);
}

abstract class OrderRepository {
  Future<void> purchaseProducts(String userId, List<CartItem> items);
}
