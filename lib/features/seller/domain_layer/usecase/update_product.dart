import '../entities/product_entity.dart';
import '../repositories/seller_repository.dart';

class UpdateProduct {
  final SellerRepository repository;

  UpdateProduct(this.repository);

  Future<void> execute(ProductEntity product) async {
    await repository.updateProduct(product);
  }
}
