import 'package:yegna_gebeya/shared/domain/models/product.dart';

abstract class ProductRepository {
  Future<void> uploadProduct({required Product product});
  Future<void> updateProductInfo({
    required String productId,
    required Product newProduct,
  });
  Future<List<Product>> getAllProducts();
  Future<List<Product>> getProductsBySellerId({required String sellerId});
  Future<Product> getProductById({required String id});
}
