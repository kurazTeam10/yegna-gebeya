import 'package:equatable/equatable.dart';
import 'package:yegna_gebeya/features/buyer/domain/models/seller.dart';

abstract class SellerListState extends Equatable {
  const SellerListState();

  @override
  List<Object> get props => [];
}

class SellerListInitial extends SellerListState {}

class SellerListLoading extends SellerListState {}

class SellerListLoaded extends SellerListState {
  final List<Seller> sellers;

  const SellerListLoaded(this.sellers);

  @override
  List<Object> get props => [sellers];
}

class SellerListError extends SellerListState {
  final String message;

  const SellerListError(this.message);

  @override
  List<Object> get props => [message];
}
