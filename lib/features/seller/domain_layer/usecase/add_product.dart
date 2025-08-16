import '../entities/product_entity.dart';
import '../repositories/seller_repository.dart';

class AddProduct {
  final SellerRepository repository;

  AddProduct(this.repository);

  Future<void> execute(ProductEntity product) async {
    await repository.addProduct(product);
  }
}
