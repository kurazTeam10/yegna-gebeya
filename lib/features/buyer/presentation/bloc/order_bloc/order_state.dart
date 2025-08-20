part of 'order_bloc.dart';

@immutable
sealed class OrderState extends Equatable {}

final class OrderInitial extends OrderState {
  @override
  List<Object?> get props => [];
}

final class OrderLoading extends OrderState {
  @override
  List<Object?> get props => [];
}

final class OrderLoaded extends OrderState {
  final List<Order> orders;

  OrderLoaded({required this.orders});

  @override
  List<Object?> get props => [...orders];
}

final class OrderError extends OrderState {
  final String message;

  OrderError({required this.message});

  @override
  List<Object?> get props => [message];
}
