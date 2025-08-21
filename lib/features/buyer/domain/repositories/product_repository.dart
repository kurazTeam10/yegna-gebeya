import 'package:yegna_gebeya/shared/domain/models/product.dart';


abstract class ProductRepository {

  Future<List<Product>> getProductsByCategory(String category);
  Future<List<Product>> searchProducts(String query);
}