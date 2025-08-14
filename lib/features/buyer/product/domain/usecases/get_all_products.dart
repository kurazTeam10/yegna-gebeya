import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';
class GetAllProducts {
  final ProductRepository repository;

  GetAllProducts(this.repository);

  Future<List<ProductEntity>> call() async {
    return await repository.getAllProducts();
  }
}