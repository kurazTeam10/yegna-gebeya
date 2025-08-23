import 'dart:io';
import 'package:dio/dio.dart';
import 'package:yegna_gebeya/shared/domain/models/image_type.dart';
import 'package:yegna_gebeya/shared/domain/repositories/image_repository.dart';

class ImageRepositoryImpl extends ImageRepository {
  final Dio dio;
  ImageRepositoryImpl({required this.dio});
  @override
  Future<String> uploadImage({
    required ImageType imageType,
    required File image,
  }) async {
    String folder = "";
    switch (imageType) {
      case ImageType.product:
        folder = "products";
      case ImageType.buyerProfile:
        folder = "buyers";

      case ImageType.sellerProfile:
        folder = "sellers";
    }
    final dbName = "dbrddd3ho";
    final url = "https://api.cloudinary.com/v1_1/$dbName/image/upload";
    final formData = FormData.fromMap({
      'upload_preset': "yegna_gebeya",
      'file': await MultipartFile.fromFile(image.path),
      'folder': folder,
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
