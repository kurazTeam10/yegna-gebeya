import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:yegna_gebeya/features/buyer/order/domain/models/order.dart';

import '../../domain/repositories/order_repository.dart';

class OrderRepositoryImpl extends OrderRepository {
  final FirebaseFirestore _firestore;

  OrderRepositoryImpl({required FirebaseFirestore firestore})
      : _firestore = firestore;

  @override
  Future<List<Order>> getOrders(String id) async {
    final querySnapshot = await _firestore
        .collection('orders')
        .where('buyerId', isEqualTo: id)
        .get();

    return querySnapshot.docs.map((doc) => Order.fromFirestore(doc)).toList();
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await _firestore.collection('orders').doc(orderId).delete();
  }

  @override
  Future<void> purchaseProduct(String id) async {
    try {
      final batch = _firestore.batch();

      final querySnapshot = await _firestore
          .collection('buyers')
          .doc(id)
          .collection('cart')
          .get();

      final orderRef = _firestore.collection('orders').doc();
      final order = Order.fromProducts(id, querySnapshot, orderRef.id);
      batch.set(orderRef, order.toMap());

      for (var doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();
    } on FirebaseException catch (e) {
      throw (Exception('Failed to purchase product ${e.message}'));
    }
  }
}
