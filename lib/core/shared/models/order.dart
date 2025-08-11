import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/core/shared/models/product.dart';

class Order {
  final List<Product> products;
  final Timestamp timestamp;

  Order({required this.products, required this.timestamp});


  factory Order.fromProducts(QuerySnapshot snapshot) {
    return Order(
      products: snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList(), timestamp: Timestamp.now(),
    );
  }

  factory Order.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Order(
      products: (data['products'] as List)
          .map((p) => Product.fromMap(p))
          .toList(),
      timestamp: data['timestamp'] as Timestamp,
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'products':products.map((product)=>product.toMap()).toList(),
      'timestamp': timestamp
    };
  }
}