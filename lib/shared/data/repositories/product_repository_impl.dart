import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';
import 'package:yegna_gebeya/shared/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final FirebaseFirestore firestore;
  ProductRepositoryImpl({required this.firestore});
  @override
  Future<List<Product>> getAllProducts() {
    return firestore.collection('products').get().then((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => Product.fromMap(doc.data()))
          .toList();
    });
  }

  @override
  Future<Product> getProductById({required String id}) async {
    final doc = await firestore.collection('products').doc(id).get();
    if (doc.exists) {
      return Product.fromMap(doc.data()!);
    } else {
      throw Exception('Product not found');
    }
  }

  @override
  Future<List<Product>> getProductsBySellerId({
    required String sellerId,
  }) async {
    final querySnapshot = await firestore
        .collection('products')
        .where('sellerId', isEqualTo: sellerId)
        .get();
    return querySnapshot.docs
        .map((doc) => Product.fromMap(doc.data()))
        .toList();
  }

  @override
  Future<void> updateProductInfo({
    required String productId,
    required Product newProduct,
  }) async {
    try {
      await firestore
          .collection('products')
          .doc(productId.trim())
          .update(newProduct.toMap());
    } on FirebaseException catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<Product> uploadProduct({required Product product}) async {
    final docRef = firestore.collection('products').doc();
    final productWithId = product.copyWith(id: docRef.id);
    await docRef.set(productWithId.toMap());
    return productWithId;
  }
}
