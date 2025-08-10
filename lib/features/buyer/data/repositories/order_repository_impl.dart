import 'package:yegna_gebeya/core/models/cart.dart';
import 'package:yegna_gebeya/features/buyer/domain/repositories/buyer_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  @override
  Future<void> purchaseProducts(String userId, List<CartItem> items) {
    // TODO: Implement Firestore logic to create an order and clear the cart
    throw UnimplementedError();
  }
}
