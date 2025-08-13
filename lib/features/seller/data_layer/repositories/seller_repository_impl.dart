import '../../domain_layer/models/product.dart';
import '../../domain_layer/models/order.dart';
import '../../domain_layer/models/seller.dart';
import '../../domain_layer/repositories/seller_repository.dart';

class SellerRepositoryImpl implements SellerRepository {
  final List<Product> _products = [];
  final List<Order> _orders = [];
  Seller? _sellerProfile;

  @override
  Future<void> addProduct(Product product) async {
    _products.add(product);
  }

  @override
  Future<void> updateProduct(Product product) async {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      _products[index] = product;
    }
  }

  @override
  Future<void> deleteProduct(String productId) async {
    _products.removeWhere((p) => p.id == productId);
  }

  @override
  Future<List<Product>> getSellerProducts(String sellerId) async {
    return _products.where((p) => p.sellerId == sellerId).toList();
  }

  @override
  Future<List<Order>> getSellerOrders(String sellerId) async {
    return _orders.where((o) => o.sellerId == sellerId).toList();
  }

  @override
  Future<void> updateOrderStatus(String orderId, bool isDelivered) async {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      _orders[index].isDelivered = isDelivered;
    }
  }

  @override
  Future<Seller> getSellerProfile(String sellerId) async {
    if (_sellerProfile != null && _sellerProfile!.id == sellerId) {
      return _sellerProfile!;
    }
    throw Exception("Seller profile not found");
  }

  @override
  Future<void> updateSellerProfile(Seller seller) async {
    _sellerProfile = seller;
  }
}
