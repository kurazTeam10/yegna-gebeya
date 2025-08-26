part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddToCartEvent extends CartEvent {
  final String id;
  final Product product;

  AddToCartEvent({required this.id, required this.product});
}

class RemoveFromCartEvent extends CartEvent {
  final String id;
  final Product product;

  RemoveFromCartEvent({required this.id, required this.product});
}

class GetCartEvent extends CartEvent {
  final String id;

  GetCartEvent({required this.id});
}

