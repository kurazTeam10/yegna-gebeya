import 'package:yegna_gebeya/shared/domain/models/product.dart';

abstract class ProductState {
  const ProductState();
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  const ProductLoaded(this.products);
}

class ProductFailure extends ProductState {
  final String message;
  const ProductFailure(this.message);
}
