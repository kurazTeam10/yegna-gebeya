import 'package:yegna_gebeya/features/buyer/data/models/cart.dart';
import 'package:yegna_gebeya/features/buyer/data/models/product.dart';
import 'package:yegna_gebeya/features/buyer/data/models/seller.dart';

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