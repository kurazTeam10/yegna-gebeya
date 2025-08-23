import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/features/seller/order/domain/repositories/order_repository.dart';
import '../../domain/models/order.dart';

class OrderRepositoryImpl extends OrderRepository {
  final FirebaseFirestore firestore;

  OrderRepositoryImpl({required this.firestore});

  @override
  Future<List<OrderModel>> getOrders() async {
    final snapshot = await firestore.collection('orders').get();
    return snapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<void> addOrder(OrderModel order) async {
    await firestore.collection('orders').add(order.toMap());
  }

  @override
  Future<void> updateOrderStatus(String orderId, String status) async {
    await firestore.collection('orders').doc(orderId).update({
      'status': status,
    });
  }
}
