import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:yegna_gebeya/features/buyer/cart/domain/repositories/cart_repository.dart';

import 'package:yegna_gebeya/shared/order/domain/models/order.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;

  CartBloc({required this.repository}) : super(CartInitial()) {
    on<GetCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        repository.getCartProducts(event.id).listen((cart) {
          final orders = cart.orders;
          final totalPrice =
              orders.fold(0.0, (sum, order) => sum + order.product.price);
          add(UpdateCartEvent(orders: orders, totalPrice: totalPrice));
        });
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });

    on<UpdateCartEvent>((event, emit) {
      emit(CartLoaded(
        orders: event.orders,
        totalPrice: event.totalPrice,
      ));
    });

    on<AddToCartEvent>((event, emit) async {
      try {
        await repository.addToCart(event.id, event.order);
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });

    on<RemoveFromCartEvent>((event, emit) async {
      try {
        await repository.removeFromCart(event.id, event.order);
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });
  }
}
