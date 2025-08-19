import 'package:equatable/equatable.dart';

abstract class SellerListEvent extends Equatable {
  const SellerListEvent();

  @override
  List<Object> get props => [];
}

class FetchSellersEvent extends SellerListEvent {}

class SearchSellersEvent extends SellerListEvent {
  final String query;

  const SearchSellersEvent(this.query);

  @override
  List<Object> get props => [query];
}
