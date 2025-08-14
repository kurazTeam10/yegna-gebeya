import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';
class SearchProducts {
  final ProductRepository repository;

  SearchProducts(this.repository);

  Future<List<ProductEntity>> call(String query) async {
    if (query.length < 2) {
      throw ArgumentError('Search query must be at least 2 characters');
    }
    return await repository.searchProducts(query);
  }
}