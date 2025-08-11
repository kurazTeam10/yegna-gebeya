import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:yegna_gebeya/core/shared/models/cart.dart';

import 'package:yegna_gebeya/core/shared/models/product.dart';
import 'package:yegna_gebeya/core/shared/models/order.dart';

import 'package:yegna_gebeya/core/shared/models/seller.dart';

import '../../domain/repositories/buyer_repository.dart';

class BuyerRepositoryImpl extends BuyerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Seller>> getSellers() {
    // TODO: implement getSellers
    throw UnimplementedError();
  }

  @override
  Future<Seller> getSellerById(String id) {
    // TODO: implement getSellerById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<Product> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<void> addToCart(String id, Product product) async {
    try {
      await _firestore
          .collection('users')
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
      final querySnapshot = await _firestore
          .collection('users')
          .doc(id)
          .collection('cart')
          .where('pid', isEqualTo: product.pid)
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
          .collection('users')
          .doc(id)
          .collection('cart')
          .snapshots()
          .map(Cart.fromFirestore);
    } on FirebaseException catch (e) {
      throw (Exception('Failed to get cart items ${e.message}'));
    }
  }

  @override
  Future<void> purchaseProduct(String id) async {
    try {

      final batch = _firestore.batch();

      final querySnapshot = await _firestore
          .collection('users')
          .doc(id)
          .collection('cart')
          .get();

      final Order order = Order.fromProducts(querySnapshot);
      _firestore.collection('users').doc(id).collection('orders').add(order.toMap());

      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } on FirebaseException catch (e) {
      throw (Exception('Failed to purchase product ${e.message}'));
    }
  }
}
