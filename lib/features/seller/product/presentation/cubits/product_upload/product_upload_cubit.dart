import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/cubits/product_cubit/product_cubit.dart';
import 'package:yegna_gebeya/shared/domain/models/image_type.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';
import 'package:yegna_gebeya/shared/domain/repositories/image_repository.dart';
import 'package:yegna_gebeya/shared/domain/repositories/product_repository.dart';
import 'product_upload_state.dart';

class ProductUploadCubit extends Cubit<ProductUploadState> {
  final ProductRepository repository;
  final ImageRepository imageRepository;
  ProductUploadCubit({required this.repository, required this.imageRepository})
    : super(ProductUploadInitial());

  openProductView({required Product product}) {
    emit(ProductUploadInitial(product: product));
  }

  Future<Product> uploadProduct({
    required Product product,
    required File image,
    required bool imageChanged,
  }) async {
    emit(const ProductUploadLoading());
    if (imageChanged) {
      final imgUrl = await imageRepository.uploadImage(
        image: image,
        imageType: ImageType.product,
      );
      product = product.copyWith(imgUrl: imgUrl);
    }
    try {
      product = await repository.uploadProduct(product: product);
      emit(ProductUploadSuccess(product: product));
    } catch (e) {
      emit(ProductUploadFailure(message: e.toString()));
    }
    return product;
  }

  Future<void> updateProductInfo({
    required String oldProductId,
    required Product product,
    required bool imageChanged,
    File? image,
  }) async {
    emit(const ProductUploadLoading());
    if (imageChanged) {
      final imgUrl = await imageRepository.uploadImage(
        image: image!,
        imageType: ImageType.product,
      );
      product = product.copyWith(imgUrl: imgUrl);
    }
    try {
      await repository.updateProductInfo(
        productId: oldProductId,
        newProduct: product,
      );
      emit(ProductUploadSuccess(product: product));
    } catch (e) {
      emit(ProductUploadFailure(message: e.toString()));
    }
  }
}
