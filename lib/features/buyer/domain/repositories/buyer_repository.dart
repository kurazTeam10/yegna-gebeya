import 'package:yegna_gebeya/features/buyer/domain/models/cart.dart';
import 'package:yegna_gebeya/features/buyer/domain/models/product.dart';
import 'package:yegna_gebeya/features/buyer/domain/models/seller.dart';

abstract class BuyerRepository {
  Stream<List<Seller>> getSellers();
  Future<Seller> getSellerById(String id);
  Stream<List<Seller>> searchSellers(String query);

  Future<List<Product>> getProducts();
  Future<Product> getProductById(String id);
  Future<List<Product>> getProductsBySellerId(String sellerId);

  Future<void> addToCart(String id, Product product);
  Future<void> removeFromCart(String id, Product product);
  Stream<Cart> getCartProducts(String id);
  Future<void> purchaseProduct(String id);
}
