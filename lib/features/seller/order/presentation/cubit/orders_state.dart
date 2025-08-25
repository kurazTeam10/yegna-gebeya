import 'package:yegna_gebeya/shared/order/domain/models/order.dart';

abstract class OrderLoadingState {}

class OrderLoadingInitial extends OrderLoadingState {}

class OrderLoading extends OrderLoadingState {}

class OrderLoadingSuccess extends OrderLoadingState {
  final List<Order> orders;
  final String activeFilter;
  final List<Order> filteredOrders;

  OrderLoadingSuccess({
    required this.orders,
    required this.filteredOrders,
    required this.activeFilter,
  });
}

class OrderLoadingFailure extends OrderLoadingState {
  final String message;
  OrderLoadingFailure(this.message);
}
