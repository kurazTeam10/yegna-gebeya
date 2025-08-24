
part of 'product_cubit.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded({required this.products});
}

class CategoriesLoaded extends ProductState {
  final List<String> categories;

  CategoriesLoaded({required this.categories});
}

class ProductError extends ProductState {
  final String message;

  ProductError({required this.message});
}