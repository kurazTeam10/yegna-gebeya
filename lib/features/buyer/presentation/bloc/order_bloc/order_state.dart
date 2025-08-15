part of 'order_bloc.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderLoaded extends OrderState {
  final List<Order> orders;

  OrderLoaded({required this.orders});
}

final class OrderError extends OrderState {
  final String message;

  OrderError({required this.message});
}
