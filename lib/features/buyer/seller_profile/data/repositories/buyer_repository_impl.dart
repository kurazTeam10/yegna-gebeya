import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:yegna_gebeya/features/buyer/seller_profile/domain/models/cart.dart';

import 'package:yegna_gebeya/shared/domain/models/product.dart';
import 'package:yegna_gebeya/features/buyer/seller_profile/domain/models/order.dart';

import 'package:yegna_gebeya/features/buyer/seller_profile/domain/models/seller.dart';

import 'package:yegna_gebeya/features/buyer/seller_profile/domain/repositories/buyer_repository.dart';

class BuyerRepositoryImpl extends BuyerRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Seller>> getSellers() {
    try {
      return _firestore.collection('sellers').snapshots().map((querySnapshot) {
        for (var doc in querySnapshot.docs) {}
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

      // Fetch all sellers and products
      final allSellers = await getSellers().first;
      final allProducts = await getProducts();

      // Create a map of sellerId to their products
      final Map<String, List<Product>> sellerProductsMap = {};
      for (var product in allProducts) {
        (sellerProductsMap[product.sellerId] ??= []).add(product);
      }

      final Set<Seller> matchingSellers = {};

      // Filter sellers by name, phone, or products
      for (var seller in allSellers) {
        // Check seller name
        if (seller.fullName.toLowerCase().contains(lowerCaseQuery)) {
          matchingSellers.add(seller);
          continue;
        }

        // Check seller phone
        if (seller.phoneNo.contains(query)) {
          matchingSellers.add(seller);
          continue;
        }

        // Check seller's products
        final productsOfSeller = sellerProductsMap[seller.id] ?? [];
        for (var product in productsOfSeller) {
          if (product.name.toLowerCase().contains(lowerCaseQuery)) {
            matchingSellers.add(seller);
            break; // Move to the next seller once a match is found
          }
        }
      }

      yield matchingSellers.toList();
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
          .where('id', isEqualTo: product.id)
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
