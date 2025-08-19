import 'package:equatable/equatable.dart';
import 'package:yegna_gebeya/features/buyer/domain/models/seller.dart';

abstract class SellerProfileState extends Equatable {
  const SellerProfileState();

  @override
  List<Object> get props => [];
}

class SellerProfileInitial extends SellerProfileState {}

class SellerProfileLoading extends SellerProfileState {}

class SellerProfileLoaded extends SellerProfileState {
  final Seller seller;

  const SellerProfileLoaded(this.seller);

  @override
  List<Object> get props => [seller];
}

class SellerProfileError extends SellerProfileState {
  final String message;

  const SellerProfileError(this.message);

  @override
  List<Object> get props => [message];
}
