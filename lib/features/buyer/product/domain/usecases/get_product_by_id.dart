import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductById {
  final ProductRepository repository;

  GetProductById(this.repository);

  Future<ProductEntity?> call(String id) async {
    if (id.isEmpty) throw ArgumentError('Product ID cannot be empty');
    return await repository.getProductById(id);
  }
}