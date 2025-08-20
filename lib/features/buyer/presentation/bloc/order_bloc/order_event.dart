part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class GetOrderHistory extends OrderEvent {
  final String id;

  GetOrderHistory({required this.id});
}

class CancelOrder extends OrderEvent {
  final String orderId;
  final String id;

  CancelOrder({required this.orderId, required this.id});
}
