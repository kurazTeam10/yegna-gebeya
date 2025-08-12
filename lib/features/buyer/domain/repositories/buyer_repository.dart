import 'package:yegna_gebeya/core/shared/models/cart.dart';
import 'package:yegna_gebeya/core/shared/models/product.dart';
import 'package:yegna_gebeya/core/shared/models/seller.dart';

abstract class BuyerRepository {
  Future<List<Seller>> getSellers();
  Future<Seller> getSellerById(String id);

  Future<List<Product>> getProducts();
  Future<Product> getProductById(String id);

  Future<void> addToCart(String id, Product product);
  Future<void> removeFromCart(String id, Product product);
  Stream<Cart> getCartProducts(String id);
  Future<void> purchaseProduct(String id);
}
