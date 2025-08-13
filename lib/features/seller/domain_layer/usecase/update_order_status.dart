import '../repositories/seller_repository.dart';

class UpdateOrderStatus {
  final SellerRepository repository;

  UpdateOrderStatus(this.repository);

  Future<void> execute(String orderId, String status) async {
    await repository.updateOrderStatus(orderId, status);
  }
}
