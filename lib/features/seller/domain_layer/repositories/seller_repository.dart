import '../models/product_model.dart';
import '../models/order_model.dart';
import '../models/seller_model.dart';

abstract class SellerRepository {
  Future<void> addProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String productId);

  Future<List<Product>> getSellerProducts(String sellerId);
  Future<List<Order>> getSellerOrders(String sellerId);

  Future<void> updateOrderStatus(String orderId, String status);

  Future<Seller> getSellerProfile(String sellerId);
  Future<void> updateSellerProfile(Seller seller);
}
