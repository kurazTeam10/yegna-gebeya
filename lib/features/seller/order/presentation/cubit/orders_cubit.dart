import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/features/seller/order/domain/repositories/order_repository.dart';

import '../../domain/models/order.dart';
import 'orders_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository orderRepository;
  List<OrderModel> _allOrders = [];

  OrderCubit({required this.orderRepository}) : super(OrderInitial());

  Future<void> fetchOrders() async {
    emit(OrderLoading());
    try {
      _allOrders = await orderRepository.getOrders();
      emit(OrderLoaded(_allOrders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await orderRepository.updateOrderStatus(orderId, newStatus);

      // also update locally
      final index = _allOrders.indexWhere((o) => o.id == orderId);
      if (index != -1) {
        _allOrders[index] = _allOrders[index].copyWith(status: newStatus);
      }

      if (state is OrderLoaded) {
        final currentFilter = (state as OrderLoaded).selectedFilter;
        filterOrders(currentFilter);
      }
    } catch (e) {
      emit(OrderError("Failed to update status: $e"));
    }
  }

  void filterOrders(String filter) {
    if (state is OrderLoaded) {
      if (filter == "all") {
        emit(OrderLoaded(_allOrders, selectedFilter: "all"));
      } else {
        final filtered = _allOrders.where((o) => o.status == filter).toList();
        emit(OrderLoaded(filtered, selectedFilter: filter));
      }
    }
  }
}
