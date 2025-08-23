part of 'product_cubit.dart';

@immutable
sealed class ProductState {
  final List<Product>? products;
  final String? errorMessage;
  const ProductState({required this.products, required this.errorMessage});
}

final class ProductInitial extends ProductState {
  const ProductInitial({super.products, super.errorMessage});
}

final class ProductLoading extends ProductState {
  const ProductLoading({super.products, super.errorMessage});
}

final class ProductLoadingSuccess extends ProductState {
  const ProductLoadingSuccess({super.products, super.errorMessage});
}

final class ProductLoadingFailure extends ProductState {
  const ProductLoadingFailure({super.products, super.errorMessage});
}
