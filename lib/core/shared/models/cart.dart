import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/core/shared/models/product.dart';

class Cart {
  List<Product> products;

  Cart({List<Product>? products}) : products = products ?? <Product>[];

  factory Cart.fromFirestore(QuerySnapshot snapshot) {
    return Cart(
      products: snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList(),
    );
  }
}
