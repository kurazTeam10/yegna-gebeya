import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:yegna_gebeya/features/buyer/cart/domain/models/cart.dart';
import 'package:yegna_gebeya/shared/models/product.dart';

import '../../domain/repositories/cart_repository.dart';


class CartRepositoryImpl extends CartRepository {
  final FirebaseFirestore _firestore;

  CartRepositoryImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  @override
  Future<void> addToCart(String id, Product product) async {
    try {
      await _firestore
          .collection('buyers')
          .doc(id)
          .collection('cart')
          .add(product.toMap());
    } on FirebaseException catch (e) {
      throw (Exception('Failed to add item to cart: ${e.message}'));
    }
  }

  @override
  Future<void> removeFromCart(String id, Product product) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('buyers')
              .doc(id)
              .collection('cart')
              .where('productId', isEqualTo: product.productId)
              .limit(1)
              .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } on FirebaseException catch (e) {
      throw (Exception('Failed to remove item from cart ${e.message}'));
    }
  }

  @override
  Stream<Cart> getCartProducts(String id) {
    try {
      return _firestore
          .collection('buyers')
          .doc(id)
          .collection('cart')
          .snapshots()
          .map(Cart.fromFirestore);
    } on FirebaseException catch (e) {
      throw (Exception('Failed to get cart items ${e.message}'));
    }
  }

  @override
  Future<void> clearCart(String id) async {
    try {
      final batch = _firestore.batch();

      final querySnapshot =
          await _firestore
              .collection('buyers')
              .doc(id)
              .collection('cart')
              .get();

      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } on FirebaseException catch (e) {
      throw (Exception('Failed to clear cart ${e.message}'));
    }
  }
}
