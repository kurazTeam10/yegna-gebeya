import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain_layer/models/order.dart';
import './orders_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final FirebaseFirestore firestore;

  List<OrderModel> _allOrders = [];

  OrderCubit(this.firestore) : super(OrderInitial());

  Future<void> fetchOrders() async {
    emit(OrderLoading());
    try {
      final snapshot = await firestore.collection("orders").get();

      _allOrders = snapshot.docs.map((doc) {
        final data = doc.data();
        return OrderModel.fromMap(data, doc.id);
      }).toList();

      emit(OrderLoaded(_allOrders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await firestore.collection("orders").doc(orderId).update({
        "status": newStatus,
      });

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
