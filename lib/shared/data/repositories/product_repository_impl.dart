// shared/data/repositories/product_repository_impl.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';
import 'package:yegna_gebeya/shared/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FirebaseFirestore firestore;

  ProductRepositoryImpl({required this.firestore});
  @override
  Future<List<String>> getCategories() async {
    try {
      final querySnapshot = await firestore
          .collection('products')
          .get();
      
      // Debug: Print all documents to see what data you're getting
      print('Fetched ${querySnapshot.docs.length} products');
      querySnapshot.docs.forEach((doc) {
        print('Product: ${doc.data()}');
      });
      
      // Extract categories with proper null handling
      final categories = querySnapshot.docs
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
      
      print('Extracted categories: $categories');
      return categories;
    } catch (e) {
      print('Error fetching categories: $e');
      throw Exception('Failed to fetch categories: $e');
    }
  }

  @override
Future<List<Product>> getAllProducts() async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('products')
      .get();
  
  return querySnapshot.docs.map((doc) => Product.fromMap(doc.data())).toList();
}
  @override
Future<List<Product>> getProductsByCategory(String category) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('products')
      .where('category', isEqualTo: category)
      .get();
  
  return querySnapshot.docs.map((doc) => Product.fromMap(doc.data())).toList();
}
  @override
  Future<List<Product>> searchProducts(String query) async {
    try {
      // Your implementation for product search
      final snapshot = await firestore
          .collection('products')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: query + 'z')
          .get();
      return snapshot.docs.map((doc) => Product.fromMap(doc.data())).toList();
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }
  
  @override
  Future<Product> getProductById({required String id}) {
    // TODO: implement getProductById
    throw UnimplementedError();
  }
  
  @override
  Future<List<Product>> getProductsBySellerId({required String sellerId}) {
    // TODO: implement getProductsBySellerId
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateProductInfo({required String productId, required Product newProduct}) {
    // TODO: implement updateProductInfo
    throw UnimplementedError();
  }
  
  @override
  Future<void> uploadProduct({required Product product}) {
    // TODO: implement uploadProduct
    throw UnimplementedError();
  }
}