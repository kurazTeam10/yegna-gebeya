import '../../domain_layer/models/order.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<OrderModel> orders;
  final String selectedFilter;

  OrderLoaded(this.orders, {this.selectedFilter = "all"});
}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}
