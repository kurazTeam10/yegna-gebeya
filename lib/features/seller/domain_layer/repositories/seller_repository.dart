import '../models/product.dart';
import '../models/order.dart';
import '../models/seller.dart';

abstract class SellerRepository {
  Future<void> addProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String productId);

  Future<List<Product>> getSellerProducts(String sellerId);
  Future<List<Order>> getSellerOrders(String sellerId);

  Future<void> updateOrderStatus(String orderId, bool isDelivered);

  Future<Seller> getSellerProfile(String sellerId);
  Future<void> updateSellerProfile(Seller seller);
}
