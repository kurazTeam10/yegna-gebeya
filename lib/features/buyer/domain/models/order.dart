import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/features/buyer/domain/models/product.dart';

class Order {
  final String? orderId;
  final String buyerId;
  final List<Product> productList;
  final DateTime orderDate;
  bool isDelivered;

  Order(
      {this.orderId,
      required this.buyerId,
      required this.productList,
      required this.orderDate,
      this.isDelivered = false});

  factory Order.fromProducts(String buyerId, QuerySnapshot snapshot) {
    return Order(
      buyerId: buyerId,
      productList:
          snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList(),
      orderDate: DateTime.now(),
    );
  }

  factory Order.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Order(
      orderId: doc['orderId'] as String,
      buyerId: doc['buyerId'] as String,
      productList:
          (data['productList'] as List).map((p) => Product.fromMap(p)).toList(),
      orderDate: data['orderDate'] as DateTime,
      isDelivered: doc['isDelivered'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'buyerId': buyerId,
      'productList': productList.map((product) => product.toMap()).toList(),
      'orderDate': orderDate,
      'isDelivered': isDelivered,
    };
  }
}
