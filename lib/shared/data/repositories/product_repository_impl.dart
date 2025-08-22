import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';
import 'package:yegna_gebeya/shared/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final FirebaseFirestore firestore;
  final Dio dio;
  ProductRepositoryImpl({required this.firestore, required this.dio});
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
  }) {
    return firestore
        .collection('products')
        .doc(productId)
        .update(newProduct.toMap());
  }

  @override
  Future<void> uploadProduct({required Product product}) {
    return _uploadImage(filePath: product.imgUrl).then((imageUrl) async {
      final updatedProduct = product.copyWith(imgUrl: imageUrl);
      final docRef = firestore.collection('products').doc();
      final productWithId = updatedProduct.copyWith(id: docRef.id);
      await docRef.set(productWithId.toMap());
    });
  }

  Future<String> _uploadImage({required String filePath}) async {
    final url = "https://api.cloudinary.com/v1_1/dbrddd3ho/image/upload";

    final formData = FormData.fromMap({
      'upload_preset': "yegna_gebeya",
      'file': await MultipartFile.fromFile(filePath),
    });

    try {
      final response = await dio.post(url, data: formData);

      if (response.statusCode == 200) {
        return response.data['secure_url'];
      } else {
        throw Exception("Upload failed: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.response?.data ?? e.message}");
    }
  }
}
