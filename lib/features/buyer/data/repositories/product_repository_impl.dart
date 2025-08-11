import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/core/shared/models/product.dart';
import 'package:yegna_gebeya/core/shared/models/seller.dart';
import 'package:yegna_gebeya/features/buyer/domain/repositories/buyer_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Product> getProductById(String productId) async {
    try {
      final doc = await _firestore.collection('products').doc(productId).get();
      if (doc.exists) {
        return Product.fromFirestore(doc);
      } else {
        throw Exception('Product not found');
      }
    } catch (e) {
      // Log the error or handle it as needed
      rethrow;
    }
  }

  @override
  Future<List<Product>> getProducts() async {
    try {
      final snapshot = await _firestore.collection('products').get();
      return snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
    } catch (e) {
      // Log the error or handle it as needed
      rethrow;
    }
  }

  @override
  Future<Seller> getSeller(DocumentReference sellerRef) async {
    try {
      final doc = await sellerRef.get();
      if (doc.exists) {
        return Seller.fromFirestore(doc);
      } else {
        throw Exception('Seller not found');
      }
    } catch (e) {
      // Log the error or handle it as needed
      rethrow;
    }
  }
}
