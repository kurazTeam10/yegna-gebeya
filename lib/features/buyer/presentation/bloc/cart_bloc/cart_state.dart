part of 'cart_bloc.dart';

@immutable
sealed class CartState extends Equatable {}

class CartInitial extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoaded extends CartState {
  final List<Product> products;
  final double totalPrice;

  CartLoaded({required this.products, required this.totalPrice});

  @override
  List<Object?> get props => [...products, totalPrice];
}

class CartError extends CartState {
  final String message;

  CartError({required this.message});

  @override
  List<Object?> get props => [message];
}
