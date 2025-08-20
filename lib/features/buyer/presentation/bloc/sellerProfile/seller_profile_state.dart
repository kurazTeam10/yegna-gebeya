import 'package:equatable/equatable.dart';
import 'package:yegna_gebeya/features/buyer/domain/models/seller.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';

abstract class SellerProfileState extends Equatable {
  const SellerProfileState();

  @override
  List<Object> get props => [];
}

class SellerProfileInitial extends SellerProfileState {}

class SellerProfileLoading extends SellerProfileState {}

class SellerProfileLoaded extends SellerProfileState {
  final Seller seller;
  final List<Product> products;

  const SellerProfileLoaded(this.seller, this.products);

  @override
  List<Object> get props => [seller, products];
}

class SellerProfileError extends SellerProfileState {
  final String message;

  const SellerProfileError(this.message);

  @override
  List<Object> get props => [message];
}
