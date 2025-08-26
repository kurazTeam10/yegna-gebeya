import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:yegna_gebeya/features/buyer/order/domain/models/order.dart';
import 'package:yegna_gebeya/features/buyer/order/domain/repositories/order_repository.dart';


part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepository repository;

  OrderBloc(this.repository) : super(OrderInitial()) {
    on<GetOrderHistory>((event, emit) async {
      emit(OrderLoading());
      try {
        final orders = await repository.getOrders(event.id);
        emit(OrderLoaded(orders: orders));
      } catch (e) {
        emit(OrderError(message: 'Failed to load orders ${e.toString()}'));
      }
    });

    on<CancelOrder>((event, emit) async {
      try {
        await repository.cancelOrder(event.orderId);
        final orders = await repository.getOrders(event.id);
        emit(OrderLoaded(orders: orders));
      } catch (e) {
        emit(OrderError(message: 'Failed to cancel order ${e.toString()}'));
      }
    });

    on<PurchaseProducts>((event, emit) async {
      emit(OrderLoading());
      try {
        await repository.purchaseProduct(event.id);
        emit(OrderSuccess());
      } catch (e) {
        emit(OrderError(message: e.toString()));
      }
    });
  }
}
