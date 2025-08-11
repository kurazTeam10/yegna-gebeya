import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/core/shared/models/cart.dart';

import 'package:yegna_gebeya/core/shared/models/product.dart';

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
  Future<List<Seller>> getSellerById(String id) {
    // TODO: implement getSellerById
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProducts() {
    // TODO: implement getProducts
    throw UnimplementedError();
  }

  @override
  Future<List<Product>> getProductById(String id) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }

  @override
  Future<void> addToCart(String id, Product product) async {
    await _firestore
        .collection('users')
        .doc(id)
        .collection('cart')
        .add(product.toMap());
  }

  @override
  Future<void> removeFromCart(String id, Product product) async {
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
  }

  @override
  Future<Cart> getCartProduct(String id) {
    // TODO: implement getCartProduct
    throw UnimplementedError();
  }

  @override
  Future<void> purchaseProduct(String id) {
    // TODO: implement purchaseProduct
    throw UnimplementedError();
  }
}
