import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain_layer/models/order.dart';

class OrderRepository {
  final FirebaseFirestore firestore;

  OrderRepository({required this.firestore});

  Stream<List<OrderModel>> getOrders() {
    return firestore.collection('orders').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }
  Future<void> addOrder(OrderModel order) async {
    await firestore.collection('orders').add(order.toMap());
  }
  Future<void> updateOrderStatus(String orderId, String status) async {
    await firestore
        .collection('orders')
        .doc(orderId)
        .update({'status': status});
  }
}
