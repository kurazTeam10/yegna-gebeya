import '../models/product.dart';
import '../models/order.dart';
import '../models/seller.dart';

abstract class SellerRepository {
  // Product operations
  Future<void> addProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String productId);

  // Fetch all products for a seller (sellerId kept for query purposes)
  Future<List<Product>> getSellerProducts(String sellerId);

  // Fetch all orders that contain products from this seller
  Future<List<Order>> getSellerOrders(String sellerId);

  
  Future<void> updateOrderStatus(String orderId, bool isDelivered);

  
  Future<Seller> getSellerProfile(String sellerId);
  Future<void> updateSellerProfile(Seller seller);
}
