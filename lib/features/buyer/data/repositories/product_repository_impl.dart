import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';

import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FirebaseFirestore _firestore;

  ProductRepositoryImpl(this._firestore);

  @override


  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final snapshot = await _firestore
          .collection('products')
          .where('category', isEqualTo: category)
          .get();
      return snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to fetch products by category: $e');
    }
  }

  @override
  Future<List<Product>> searchProducts(String query) async {
    try {
      final snapshot = await _firestore.collection('products').get();
      final allProducts = snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList();
      return allProducts
          .where((product) => product.productName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }
}