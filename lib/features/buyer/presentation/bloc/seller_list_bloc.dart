import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/features/buyer/domain/repositories/buyer_repository.dart';
import 'seller_list_event.dart';
import 'seller_list_state.dart';

class SellerListBloc extends Bloc<SellerListEvent, SellerListState> {
  final BuyerRepository buyerRepository;

  SellerListBloc({required this.buyerRepository}) : super(SellerListInitial()) {
    on<FetchSellersEvent>(_onFetchSellers);
    on<SearchSellersEvent>(_onSearchSellers);
  }

  Future<void> _onFetchSellers(
    FetchSellersEvent event,
    Emitter<SellerListState> emit,
  ) async {
    emit(SellerListLoading());
    try {
      final sellers = await buyerRepository.getSellers();
      emit(SellerListLoaded(sellers));
    } catch (e) {
      emit(SellerListError(e.toString()));
    }
  }

  Future<void> _onSearchSellers(
    SearchSellersEvent event,
    Emitter<SellerListState> emit,
  ) async {
    emit(SellerListLoading());
    try {
      final sellers = await buyerRepository.searchSellers(event.query);
      emit(SellerListLoaded(sellers));
    } catch (e) {
      emit(SellerListError(e.toString()));
    }
  }
}
