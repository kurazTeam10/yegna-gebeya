import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:yegna_gebeya/features/buyer/domain/models/cart.dart';

import 'package:yegna_gebeya/features/buyer/domain/models/product.dart';
import 'package:yegna_gebeya/features/buyer/domain/models/order.dart';

import 'package:yegna_gebeya/features/buyer/domain/models/seller.dart';

import '../../domain/repositories/buyer_repository.dart';

class BuyerRepositoryImpl extends BuyerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Seller>> getSellers() {
    try {
      return _firestore.collection('sellers').snapshots().map((querySnapshot) {
        print('Firebase query returned ${querySnapshot.docs.length} documents');
        for (var doc in querySnapshot.docs) {
          print('Document data: ${doc.data()}');
        }
        return querySnapshot.docs
            .map((doc) => Seller.fromFirestore(doc))
            .toList();
      });
    } on FirebaseException catch (e) {
      print('Firebase error: ${e.message}');
      throw Exception('Failed to get sellers ${e.message}');
    } catch (e) {
      print('General error: $e');
      throw Exception('Failed to get sellers: $e');
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
  Stream<List<Seller>> searchSellers(String query) async* {
    if (query.isEmpty) {
      yield* getSellers();
      return;
    }

    try {
      final lowerCaseQuery = query.toLowerCase();

      // 1. Search sellers by name (case-insensitive)
      final sellerNameQuery = _firestore
          .collection('sellers')
          .where('fullName', isGreaterThanOrEqualTo: lowerCaseQuery)
          .where('fullName', isLessThanOrEqualTo: '$lowerCaseQuery\uf8ff');

      // 2. Search sellers by phone
      final sellerPhoneQuery =
          _firestore.collection('sellers').where('phone', isEqualTo: query);

      // 3. Search products by name and get unique seller IDs
      final productQuery = await _firestore
          .collection('products')
          .where('productName', isGreaterThanOrEqualTo: lowerCaseQuery)
          .where('productName', isLessThanOrEqualTo: '$lowerCaseQuery\uf8ff')
          .get();

      final sellerIdsFromProducts = productQuery.docs
          .map((doc) => doc.data()['sellerId'] as String)
          .toSet();

      // Combine all results
      final nameResults = await sellerNameQuery.get();
      final phoneResults = await sellerPhoneQuery.get();

      final Map<String, Seller> combinedSellers = {};

      for (var doc in [...nameResults.docs, ...phoneResults.docs]) {
        final seller = Seller.fromFirestore(doc);
        combinedSellers[seller.userId] = seller;
      }

      if (sellerIdsFromProducts.isNotEmpty) {
        for (var sellerId in sellerIdsFromProducts) {
          if (!combinedSellers.containsKey(sellerId)) {
            final seller = await getSellerById(sellerId);
            combinedSellers[sellerId] = seller;
          }
        }
      }

      yield combinedSellers.values.toList();
    } catch (e) {
      yield* Stream.error(Exception('Failed to search sellers: $e'));
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
  Future<Product> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductsBySellerId(String sellerId) async {
    try {
      final querySnapshot = await _firestore
          .collection('products')
          .where('sellerId', isEqualTo: sellerId)
          .get();

      return querySnapshot.docs.map((doc) {
        try {
          return Product.fromFirestore(doc);
        } catch (e) {
          print('Error parsing product ${doc.id}: $e');
          print('Document data: ${doc.data()}');
          rethrow;
        }
      }).toList();
    } catch (e) {
      print('Failed to fetch products for seller $sellerId: $e');
      throw Exception('Failed to fetch products for seller: $e');
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
