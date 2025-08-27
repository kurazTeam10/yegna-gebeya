part of 'cart_bloc.dart';

@immutable
sealed class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class AddToCartEvent extends CartEvent {
  final String id;
  final Order order;

  AddToCartEvent({required this.id, required this.order});
}

class UpdateCartEvent extends CartEvent {
  @override
  List<Object?> get props => [orders, totalPrice];

  final List<Order> orders;
  final double totalPrice;

  UpdateCartEvent({required this.orders, required this.totalPrice});

  }

class RemoveFromCartEvent extends CartEvent {
  final String id;
  final Order order;

  RemoveFromCartEvent({required this.id, required this.order});
}

class GetCartEvent extends CartEvent {
  final String id;

  GetCartEvent({required this.id});
}

