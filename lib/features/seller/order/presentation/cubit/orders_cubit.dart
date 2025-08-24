import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/features/seller/order/domain/models/order.dart';
import 'package:yegna_gebeya/features/seller/order/domain/repositories/order_repository.dart';

import 'orders_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository orderRepository;

  OrderCubit({required this.orderRepository}) : super(OrderInitial());

  Future<void> fetchOrders(String sellerId) async {
    emit(OrderLoading());
    try {
      List<Order> myOrders = await orderRepository.getOrders("seller1");
      emit(OrderLoaded(myOrders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    try {
      await orderRepository.updateOrderStatus(orderId, newStatus);
      final orders = (state as OrderLoaded).orders.map((order) {
        if (order.id == orderId) {
          return order.copyWith(status: newStatus);
        }
        return order;
      }).toList();
      emit(
        OrderLoaded(
          orders,
          selectedFilter: (state as OrderLoaded).selectedFilter,
        ),
      );
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  void filterOrders(String filter) {
    if (state is OrderLoaded) {
      final allOrders = (state as OrderLoaded).orders;
      if (filter == "all") {
        emit(OrderLoaded(allOrders, selectedFilter: "all"));
      } else {
        final filtered = allOrders.where((o) => o.status == filter).toList();
        emit(OrderLoaded(filtered, selectedFilter: filter));
      }
    }
  }
}
