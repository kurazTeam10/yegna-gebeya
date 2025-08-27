import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
// import 'package:flutter/foundation.dart';
import 'package:yegna_gebeya/shared/order/domain/models/order.dart';

class Cart {
  List<Order> orders;

  Cart({List<Order>? orders}) : orders = orders ?? <Order>[];

  factory Cart.fromFirestore(QuerySnapshot snapshot) {
    return Cart(
      orders: snapshot.docs
            .map((doc) => Order.fromMap(doc.data() as Map<String, dynamic>, doc.id))
            .toList(),
    );
  }
}
