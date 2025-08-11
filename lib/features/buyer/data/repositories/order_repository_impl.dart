import 'package:cloud_firestore/cloud_firestore.dart'
    hide Order; // <-- FIX IS HERE
import 'package:yegna_gebeya/core/models/cart.dart';
import 'package:yegna_gebeya/core/models/order.dart';
import 'package:yegna_gebeya/features/buyer/domain/repositories/buyer_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> purchaseProducts(String userId, List<CartItem> items) async {
    if (items.isEmpty) {
      throw Exception('Cannot create an order with no items.');
    }

    final batch = _firestore.batch();

    // 1. Prepare the new order document
    final orderRef = _firestore.collection('orders').doc();

    final totalAmount = items.fold(
        0.0, (sum, item) => sum + (item.product.price * item.quantity));

    final orderItems = items
        .map((cartItem) => OrderItem(
              productId: cartItem.product.id,
              name: cartItem.product.name, // Snapshot name
              quantity: cartItem.quantity,
              price: cartItem.product.price, // Snapshot price
            ))
        .toList();

    final newOrder = Order(
      orderId: orderRef.id,
      userId: userId,
      totalAmount: totalAmount,
      orderDate: DateTime.now(),
      items: orderItems,
    );

    // 2. Add the order creation to the batch
    batch.set(orderRef, newOrder.toFirestore());

    // 3. Add the cart-clearing operations to the batch
    final cartCollectionRef =
        _firestore.collection('buyers').doc(userId).collection('cart');
    for (final cartItem in items) {
      final cartItemRef = cartCollectionRef.doc(cartItem.product.id);
      batch.delete(cartItemRef);
    }

    // 4. Commit the atomic operation
    await batch.commit();
  }
}
