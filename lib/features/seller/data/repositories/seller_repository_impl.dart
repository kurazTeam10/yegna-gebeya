/*import 'package:yegna_gebeya/features/seller/domain_layer/models/product_model.dart';
import 'package:yegna_gebeya/features/seller/domain_layer/models/order_model.dart';
import 'package:yegna_gebeya/features/seller/domain_layer/models/seller_model.dart';
import 'package:yegna_gebeya/features/seller/domain_layer/repositories/seller_repository.dart';

class SellerRepositoryImpl implements SellerRepository {
  final List<Product> _products = [];
  final List<Order> _orders = [];
  Seller? _seller;

  SellerRepositoryImpl();

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
  Future<void> updateOrderStatus(String orderId, String status) async {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      final oldOrder = _orders[index];
      _orders[index] = Order(
        id: oldOrder.id,
        sellerId: oldOrder.sellerId,
        productList: oldOrder.productList,
        buyerId: oldOrder.buyerId,
        orderDate: oldOrder.orderDate,
        isDelivered: status.toLowerCase() == 'delivered',
      );
    }
  }

  @override
  Future<Seller> getSellerProfile(String sellerId) async {
    if (_seller == null || _seller!.id != sellerId) {
     
      _seller = Seller(id: sellerId, fullName: 'Demo Seller', email: 'demo@example.com');
    }
    return _seller!;
  }

  @override
  Future<void> updateSellerProfile(Seller seller) async {
    _seller = seller;
  }
}*/
