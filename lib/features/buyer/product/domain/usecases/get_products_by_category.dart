import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';
class GetProductsByCategory {
  final ProductRepository repository;

  GetProductsByCategory(this.repository);

  Future<List<ProductEntity>> call(String category) async {
    if (category.isEmpty) throw ArgumentError('Category cannot be empty');
    return await repository.getProductsByCategory(category);
  }
}