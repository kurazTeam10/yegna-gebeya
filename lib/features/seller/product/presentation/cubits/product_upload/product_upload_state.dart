import 'package:yegna_gebeya/shared/domain/models/product.dart';

sealed class ProductUploadState {
  const ProductUploadState();
}

class ProductUploadInitial extends ProductUploadState {
  Product? product;
  ProductUploadInitial({this.product});
}

class ProductUploadLoading extends ProductUploadState {
  const ProductUploadLoading();
}

class ProductUploadFailure extends ProductUploadState {
  final String message;
  const ProductUploadFailure({required this.message});
}

class ProductUploadSuccess extends ProductUploadState {
  Product product;
  ProductUploadSuccess({required this.product});
}
