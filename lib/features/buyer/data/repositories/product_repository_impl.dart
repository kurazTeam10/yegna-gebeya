import 'package:yegna_gebeya/core/models/product.dart';
import 'package:yegna_gebeya/features/buyer/domain/repositories/buyer_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<Product> getProductById(String productId) {
    // TODO: Implement Firestore logic to fetch a single product
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProducts() {
    // TODO: Implement Firestore logic to fetch all products
    throw UnimplementedError();
  }
}
