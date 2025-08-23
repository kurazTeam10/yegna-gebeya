sealed class ProductUploadState {
  const ProductUploadState();
}

class ProductUploadInitial extends ProductUploadState {
  const ProductUploadInitial();
}

class ProductUploadLoading extends ProductUploadState {
  const ProductUploadLoading();
}

class ProductUploadFailure extends ProductUploadState {
  final String message;
  const ProductUploadFailure(this.message);
}

class ProductUploadSuccess extends ProductUploadState {
  const ProductUploadSuccess();
}
