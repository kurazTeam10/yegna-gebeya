/*
import 'package:yegna_gebeya/features/seller/data/datasources/seller_remote_data_source.dart';
import 'package:yegna_gebeya/features/seller/domain/entities/seller.dart';
import 'package:yegna_gebeya/features/seller/domain/repositories/seller_repository.dart';

class SellerRepositoryImpl implements SellerRepository {
  final SellerRemoteDataSource remoteDataSource;

  SellerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Seller> signUp(Seller seller) {
    return remoteDataSource.signUp(seller);
  }

  @override
  Future<Product> createProduct(Product product) {
    return remoteDataSource.createProduct(product);
  }

  @override
  Future<void> removeProduct(String productId) {
    return remoteDataSource.removeProduct(productId);
  }

  @override
  Future<List<Order>> getOrders(String sellerId) {
    return remoteDataSource.getOrders(sellerId);
  }

  @override
  Future<void> deliverOrder(String orderId) {
    return remoteDataSource.deliverOrder(orderId);
  }
}
*/
