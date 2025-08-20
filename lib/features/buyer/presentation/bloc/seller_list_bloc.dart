import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/features/buyer/domain/repositories/buyer_repository.dart';
import 'package:yegna_gebeya/features/buyer/domain/models/seller.dart';
import 'seller_list_event.dart';
import 'seller_list_state.dart';

class SellerListBloc extends Bloc<SellerListEvent, SellerListState> {
  final BuyerRepository buyerRepository;
  StreamSubscription? _sellersSubscription;

  SellerListBloc({required this.buyerRepository}) : super(SellerListInitial()) {
    on<FetchSellersEvent>(_onFetchSellers);
    on<SearchSellersEvent>(_onSearchSellers);
  }

  Future<void> _onFetchSellers(
    FetchSellersEvent event,
    Emitter<SellerListState> emit,
  ) async {
    emit(SellerListLoading());

    await _sellersSubscription?.cancel();

    try {
      await emit.forEach<List<Seller>>(
        buyerRepository.getSellers(),
        onData: (sellers) => SellerListLoaded(sellers),
        onError: (error, stackTrace) => SellerListError(error.toString()),
      );
    } catch (e) {
      emit(SellerListError(e.toString()));
    }
  }

  Future<void> _onSearchSellers(
    SearchSellersEvent event,
    Emitter<SellerListState> emit,
  ) async {
    emit(SellerListLoading());

    await _sellersSubscription?.cancel();

    try {
      await emit.forEach<List<Seller>>(
        buyerRepository.searchSellers(event.query),
        onData: (sellers) => SellerListLoaded(sellers),
        onError: (error, stackTrace) => SellerListError(error.toString()),
      );
    } catch (e) {
      emit(SellerListError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _sellersSubscription?.cancel();
    return super.close();
  }
}
