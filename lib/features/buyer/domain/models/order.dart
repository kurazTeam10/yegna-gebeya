import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/features/buyer/domain/models/product.dart';

class Order {
  final String? id;
  final String buyerId;
  final List<Product> products;
  final Timestamp timestamp;
  bool isDelivered;

  Order({this.id, required this.buyerId,required this.products, required this.timestamp, this.isDelivered = false});


  factory Order.fromProducts(String buyerId, QuerySnapshot snapshot) {
    return Order(
      buyerId: buyerId,
      products: snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList(), timestamp: Timestamp.now(),
    );
  }

  factory Order.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Order(
      id: doc['id'] as String,
      buyerId: doc['buyerId'] as String,
      products: (data['products'] as List)
          .map((p) => Product.fromMap(p))
          .toList(),
      timestamp: data['timestamp'] as Timestamp,
      isDelivered: doc['isDelivered'] as bool,
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'id': id,
      'buyerId': buyerId,
      'products':products.map((product)=>product.toMap()).toList(),
      'timestamp': timestamp,
      'isDelivered': isDelivered,
    };
  }
}