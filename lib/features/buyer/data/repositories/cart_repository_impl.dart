import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/core/models/cart.dart';
import 'package:yegna_gebeya/core/models/product.dart';
import 'package:yegna_gebeya/features/buyer/domain/repositories/buyer_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addProductToCart(
      String userId, String productId, int quantity) async {
    final cartItemRef = _firestore
        .collection('buyers')
        .doc(userId)
        .collection('cart')
        .doc(productId);

    return _firestore.runTransaction((transaction) async {
      final snapshot = await transaction.get(cartItemRef);

      if (!snapshot.exists) {
        transaction.set(cartItemRef, {'quantity': quantity});
      } else {
        final newQuantity = snapshot.data()!['quantity'] + quantity;
        transaction.update(cartItemRef, {'quantity': newQuantity});
      }
    });
  }

  @override
  Future<Cart> getCart(String userId) async {
    final cartSnapshot = await _firestore
        .collection('buyers')
        .doc(userId)
        .collection('cart')
        .get();

    if (cartSnapshot.docs.isEmpty) {
      return Cart(userId: userId, items: []);
    }

    final productFutures = cartSnapshot.docs.map((doc) async {
      final productDoc =
          await _firestore.collection('products').doc(doc.id).get();
      final product = Product.fromFirestore(productDoc);
      final quantity = doc.data()['quantity'] as int;
      return CartItem(product: product, quantity: quantity);
    }).toList();

    final cartItems = await Future.wait(productFutures);
    return Cart(userId: userId, items: cartItems);
  }

  @override
  Future<void> removeProductFromCart(String userId, String productId) async {
    final cartItemRef = _firestore
        .collection('buyers')
        .doc(userId)
        .collection('cart')
        .doc(productId);
    await cartItemRef.delete();
  }
}
