import 'package:yegna_gebeya/features/seller/order/domain/models/order.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<Order> orders;
  final String selectedFilter;

  OrderLoaded(this.orders, {this.selectedFilter = "all"});
}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}
