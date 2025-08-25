// shared/data/repositories/product_repository_impl.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';
import 'package:yegna_gebeya/shared/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final FirebaseFirestore firestore;
  ProductRepositoryImpl({required this.firestore});

  @override
  Future<List<String>> getCategories() async {
    try {
      final querySnapshot = await firestore.collection('products').get();
      final categories =
          querySnapshot.docs
              .map((doc) {
                final data = doc.data();
                final category = data['category'];
                return category is String ? category : null;
              })
              .where((category) => category != null && category.isNotEmpty)
              .map((category) => category!) // Convert String? to String
              .toSet() // Remove duplicates
              .toList()
            ..sort(); // Optional: sort alphabetically

      return categories;
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .get();

    return querySnapshot.docs
        .map((doc) => Product.fromMap(doc.data()))
        .toList();
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: category)
        .get();

    return querySnapshot.docs
        .map((doc) => Product.fromMap(doc.data()))
        .toList();
  }

  @override
 Future<List<Product>> searchProducts(String query) async {
  final allProducts = await getAllProducts();
  return allProducts
      .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
      .toList();
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
  Future<Product> uploadProduct({required Product product}) async {
    final docRef = firestore.collection('products').doc();
    final productWithId = product.copyWith(id: docRef.id);
    await docRef.set(productWithId.toMap());
    return productWithId;
  }
}
