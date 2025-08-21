import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';
import 'package:yegna_gebeya/shared/domain/repositories/product_repository.dart';
import 'product_upload_state.dart';

class ProductUploadCubit extends Cubit<ProductUploadState> {
  final ProductRepository repository;
  ProductUploadCubit({required this.repository})
    : super(const ProductUploadInitial());

  Future<void> uploadProduct(Product product) async {
    emit(const ProductUploadLoading());
    try {
      await repository.uploadProduct(product: product);
      emit(const ProductUploadSuccess());
    } catch (e) {
      emit(ProductUploadFailure(e.toString()));
    }
  }
}
