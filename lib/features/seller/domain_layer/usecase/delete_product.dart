import '../repositories/seller_repository.dart';

class DeleteProduct {
  final SellerRepository repository;

  DeleteProduct(this.repository);

  Future<void> execute(String productId) async {
    await repository.deleteProduct(productId);
  }
}
