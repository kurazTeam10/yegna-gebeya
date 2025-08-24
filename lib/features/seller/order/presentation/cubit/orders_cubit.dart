import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/shared/order/domain/models/order.dart';
import 'package:yegna_gebeya/shared/order/domain/repositories/order_repository.dart';

import 'orders_state.dart';

class OrderCubit extends Cubit<OrderLoadingState> {
  final OrderRepository orderRepository;

  OrderCubit({required this.orderRepository}) : super(OrderLoadingInitial());

  Future<void> fetchOrders(String sellerId) async {
    emit(OrderLoading());
    try {
      List<Order> myOrders = await orderRepository.getOrders("seller1");
      emit(
        OrderLoadingSuccess(
          orders: myOrders,
          filteredOrders: myOrders,
          activeFilter: "all",
        ),
      );
    } catch (e) {
      emit(OrderLoadingFailure(e.toString()));
    }
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus newStatus) async {
    try {
      await orderRepository.updateOrderStatus(orderId, newStatus);
      final orders = (state as OrderLoadingSuccess).orders.map((order) {
        if (order.id == orderId) {
          return order.copyWith(status: newStatus);
        }
        return order;
      }).toList();
      emit(
        OrderLoadingSuccess(
          orders: orders,
          filteredOrders: orders,
          activeFilter: "all",
        ),
      );
    } catch (e) {
      emit(OrderLoadingFailure(e.toString()));
    }
  }

  void filterOrders(String filter) {
    if (state is OrderLoadingSuccess) {
      final allOrders = (state as OrderLoadingSuccess).orders;
      if (filter == "all") {
        emit(
          OrderLoadingSuccess(
            orders: allOrders,
            filteredOrders: allOrders,
            activeFilter: filter,
          ),
        );
      } else {
        final filtered = allOrders
            .where((o) => o.status.name == filter)
            .toList();
        emit(
          OrderLoadingSuccess(
            orders: allOrders,
            filteredOrders: filtered,
            activeFilter: filter,
          ),
        );
      }
    }
  }
}
