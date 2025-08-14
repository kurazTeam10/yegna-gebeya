import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getAllProducts();
  Future<List<ProductModel>> getProductsByCategory(String category);
  Future<List<ProductModel>> searchProducts(String query);
  Future<ProductModel?> getProductById(String id);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final FirebaseFirestore _firestore;

  ProductRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final snapshot = await _firestore.collection('products').get();
    return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final snapshot = await _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .get();
    return snapshot.docs.map((doc) => ProductModel.fromFirestore(doc)).toList();
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    final allProducts = await getAllProducts();
    return allProducts
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<ProductModel?> getProductById(String id) async {
    final doc = await _firestore.collection('products').doc(id).get();
    return doc.exists ? ProductModel.fromFirestore(doc) : null;
  }
}