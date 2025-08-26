import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:yegna_gebeya/shared/models/product.dart';
import 'package:yegna_gebeya/shared/models/seller.dart';

import '../../domain/repositories/buyer_repository.dart';

class BuyerRepositoryImpl extends BuyerRepository {
  final FirebaseFirestore _firestore;

  BuyerRepositoryImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

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
 
}
