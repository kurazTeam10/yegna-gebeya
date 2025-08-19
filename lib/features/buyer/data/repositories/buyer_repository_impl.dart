import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:yegna_gebeya/features/buyer/domain/models/cart.dart';

import 'package:yegna_gebeya/features/buyer/domain/models/product.dart';
import 'package:yegna_gebeya/features/buyer/domain/models/order.dart';

import 'package:yegna_gebeya/features/buyer/domain/models/seller.dart';

import '../../domain/repositories/buyer_repository.dart';

class BuyerRepositoryImpl extends BuyerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Seller>> getSellers() async {
    try {
      final querySnapshot = await _firestore.collection('sellers').get();
      return querySnapshot.docs
          .map((doc) => Seller.fromFirestore(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw (Exception('Failed to get sellers ${e.message}'));
    }
  }

  @override
  Future<Seller> getSellerById(String id) async {
    try {
      final sellerDoc = await _firestore.collection('sellers').doc(id).get();
      return Seller.fromFirestore(sellerDoc);
    } on FirebaseException catch (e) {
      throw (Exception('Failed to get seller ${e.message}'));
    }
  }

  @override
  Future<List<Seller>> searchSellers(String query) async {
    try {
      final querySnapshot = await _firestore
          .collection('sellers')
          .where('fullName', isGreaterThanOrEqualTo: query)
          .where('fullName', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      return querySnapshot.docs
          .map((doc) => Seller.fromFirestore(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw (Exception('Failed to search sellers ${e.message}'));
    }
  }

  @override
  Future<List<Product>> getProducts() async {
    try {
      final querySnapshot = await _firestore.collection('products').get();
      return querySnapshot.docs
          .map((doc) => Product.fromFirestore(doc))
          .toList();
    } on FirebaseException catch (e) {
      throw (Exception('Failed to get products ${e.message}'));
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      final productDoc = await _firestore.collection('products').doc(id).get();
      return Product.fromFirestore(productDoc);
    } on FirebaseException catch (e) {
      throw (Exception('Failed to get product ${e.message}'));
    }
  }

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
      final querySnapshot = await _firestore
          .collection('buyers')
          .doc(id)
          .collection('cart')
          .where('id', isEqualTo: product.productId)
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
  Future<void> purchaseProduct(String id) async {
    try {
      final batch = _firestore.batch();

      final querySnapshot = await _firestore
          .collection('buyers')
          .doc(id)
          .collection('cart')
          .get();

      final Order order = Order.fromProducts(id, querySnapshot);
      _firestore.collection('orders').add(order.toMap());

      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } on FirebaseException catch (e) {
      throw (Exception('Failed to purchase product ${e.message}'));
    }
  }
}
