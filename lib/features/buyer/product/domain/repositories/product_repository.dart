import '../entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getAllProducts();
  Future<List<ProductEntity>> getProductsByCategory(String category);
  Future<List<ProductEntity>> searchProducts(String query);
  Future<ProductEntity?> getProductById(String id);
}