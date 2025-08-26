import 'package:yegna_gebeya/shared/models/product.dart';
import 'package:yegna_gebeya/shared/models/seller.dart';

abstract class BuyerRepository {
  Future<List<Seller>> getSellers();
  Future<Seller> getSellerById(String id);

  Future<List<Product>> getProducts();
  Future<Product> getProductById(String id);
  
}
