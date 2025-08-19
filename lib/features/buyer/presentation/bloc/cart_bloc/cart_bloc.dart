import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:yegna_gebeya/features/buyer/domain/repositories/buyer_repository.dart';

import '../../../../../shared/models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final BuyerRepository repository;

  CartBloc({required this.repository}) : super(CartInitial()) {
    on<GetCartEvent>((event, emit) async {
            emit(CartLoading());
      await emit.forEach(
        repository.getCartProducts(event.id),
        onData: (data) {
          return CartLoaded(
            products: data.products,
            totalPrice: data.products.isNotEmpty
                ? data.products
                      .map((e) => e.price)
                      .toList()
                      .reduce((value, element) => value + element)
                : 0.0,
          );
        },
        onError: (error, stackTrace) => CartError(message: error.toString()),
      );
    });

    on<AddToCartEvent>((event, emit) async {
      try {
        await repository.addToCart(event.id, event.product);
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });

    on<RemoveFromCartEvent>((event, emit) async {
      try {
        await repository.removeFromCart(event.id, event.product);
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });

    on<PurchaseProducts>((event, emit) async {
      try {
        await repository.purchaseProduct(event.id);
      } catch (e) {
        emit(CartError(message: e.toString()));
      }
    });
  }
}
