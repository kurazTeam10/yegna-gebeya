import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? id;
  final String name;
  final String photoUrl;
  final String description;
  final double cost;
  final String sellerId;

  Product({
    this.id,
    required this.name,
    required this.photoUrl,
    required this.description,
    required this.cost,
    required this.sellerId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'description': description,
      'cost': cost,
      'sellerId': sellerId,
    };
  }

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> docMap = doc.data() as Map<String, dynamic>;
    return Product.fromMap(docMap);
  }

  factory Product.fromMap(Map<String,dynamic> map){
    return Product(
      id: map['id'],
      name: map['name'],
      photoUrl: map['photoUrl'],
      description: map['description'],
      cost: map['cost'],
      sellerId: map['sellerId'],
    );
  }

}
