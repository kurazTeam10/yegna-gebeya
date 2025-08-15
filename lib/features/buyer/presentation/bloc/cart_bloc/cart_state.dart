part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Product> products;
  final double totalPrice;

  CartLoaded({required this.products, required this.totalPrice});
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});
}
