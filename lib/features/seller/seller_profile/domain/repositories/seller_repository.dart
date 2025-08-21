
import 'package:yegna_gebeya/features/seller/seller_profile/domain/models/seller.dart';

abstract class SellerRepository {
  Future<void> registerSeller({required Seller seller});
  Future<void> getSellerInfo({required String sellerId});
  Future<void> updateSellerInfo({
    required String sellerId,
    required Seller seller,
  });
}
