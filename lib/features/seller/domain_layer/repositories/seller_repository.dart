import '../entities/product_entity.dart';
import '../entities/order_entity.dart';
import '../entities/seller_entity.dart';

abstract class SellerRepository {
  Future<void> addProduct(ProductEntity product);
  Future<void> updateProduct(ProductEntity product);
  Future<void> deleteProduct(String productId);

  Future<List<ProductEntity>> getSellerProducts(String sellerId);
  Future<List<OrderEntity>> getSellerOrders(String sellerId);

  Future<void> updateOrderStatus(String orderId, String status);

  Future<SellerEntity> getSellerProfile(String sellerId);
  Future<void> updateSellerProfile(SellerEntity seller);
}
