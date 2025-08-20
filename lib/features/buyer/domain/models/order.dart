import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/shared/models/product.dart';

class Order {
  final String? orderId;
  final String buyerId;
  final List<Product> productList;
  final DateTime orderDate;
  bool? isDelivered;

  Order({
    this.orderId,
    required this.buyerId,
    required this.productList,
    required this.orderDate,
    this.isDelivered = false,
  });

  factory Order.fromProducts(
    String buyerId,
    QuerySnapshot snapshot,
    String orderId,
  ) {
    return Order(
      orderId: orderId,
      buyerId: buyerId,
      productList: snapshot.docs
          .map((doc) => Product.fromFirestore(doc))
          .toList(),
      orderDate: DateTime.now(),
      isDelivered: false
    );
  }

  factory Order.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Order(
      orderId: doc.id,
      buyerId: data['buyerId'] as String,
      productList: (data['productList'] as List)
          .map((p) => Product.fromMap(p))
          .toList(),
      orderDate: (data['orderDate'] as Timestamp).toDate(),
      isDelivered: data['isDelivered'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'buyerId': buyerId,
      'productList': productList.map((product) => product.toMap()).toList(),
      'orderDate': Timestamp.fromDate(orderDate),
      'isDelivered': isDelivered,
    };
  }
}
