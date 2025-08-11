import '../entities/product_entity.dart';
import '../repositories/seller_repository.dart';

class GetSellerProducts {
  final SellerRepository repository;

  GetSellerProducts(this.repository);

  Future<List<ProductEntity>> execute(String sellerId) async {
    return await repository.getSellerProducts(sellerId);
  }
}
