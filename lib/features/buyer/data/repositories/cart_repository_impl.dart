import 'package:yegna_gebeya/core/models/cart.dart';
import 'package:yegna_gebeya/features/buyer/domain/repositories/buyer_repository.dart';

class CartRepositoryImpl implements CartRepository {
  @override
  Future<void> addProductToCart(String userId, String productId, int quantity) {
    // TODO: Implement Firestore logic to add a product to the cart
    throw UnimplementedError();
  }

  @override
  Future<Cart> getCart(String userId) {
    // TODO: Implement Firestore logic to get the user's cart
    throw UnimplementedError();
  }

  @override
  Future<void> removeProductFromCart(String userId, String productId) {
    // TODO: Implement Firestore logic to remove a product from the cart
    throw UnimplementedError();
  }
}
