import 'package:equatable/equatable.dart';

abstract class SellerProfileEvent extends Equatable {
  const SellerProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchSellerProfileEvent extends SellerProfileEvent {
  final String sellerId;

  const FetchSellerProfileEvent(this.sellerId);

  @override
  List<Object> get props => [sellerId];
}
