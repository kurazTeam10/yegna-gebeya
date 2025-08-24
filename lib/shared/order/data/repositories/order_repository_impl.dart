import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/features/seller/order/domain/models/order.dart'
    as model;
import 'package:yegna_gebeya/features/seller/order/domain/repositories/order_repository.dart';
import 'package:yegna_gebeya/shared/domain/repositories/product_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  final FirebaseFirestore firestore;
  final ProductRepository productRepository;

  OrderRepositoryImpl({
    required this.firestore,
    required this.productRepository,
  });

  @override
  Future<List<model.Order>> getOrders(String sellerId) async {
    final snapshot = await firestore
        .collection('orders')
        .where("sellerId", isEqualTo: sellerId)
        .get();
    List<model.Order> orders = [];
    for (final doc in snapshot.docs) {
      final data = doc.data();
      final productId = data['productId'];
      final product = await productRepository.getProductById(id: productId);
      final order = model.Order.fromMap({
        ...data,
        'product': product.toMap(),
      }, doc.id);
      orders.add(order);
    }
    return orders;
  }

  @override
  Future<void> addOrder(model.Order order) async {
    await firestore.collection('orders').add(order.toMap());
  }

  @override
  Future<void> updateOrderStatus(
    String orderId,
    model.OrderStatus status,
  ) async {
    await firestore.collection('orders').doc(orderId).update({
      'status': status.name,
    });
  }
}
