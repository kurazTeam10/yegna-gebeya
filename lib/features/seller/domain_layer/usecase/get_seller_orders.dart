import '../entities/order_entity.dart';
import '../repositories/seller_repository.dart';

class GetSellerOrders {
  final SellerRepository repository;

  GetSellerOrders(this.repository);

  Future<List<OrderEntity>> execute(String sellerId) async {
    return await repository.getSellerOrders(sellerId);
  }
}
