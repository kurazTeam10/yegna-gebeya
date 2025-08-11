import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? pid;
  final String name;
  final String photoUrl;
  final String description;
  final double cost;
  final String uid;

  Product({
    this.pid,
    required this.name,
    required this.photoUrl,
    required this.description,
    required this.cost,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'pid': pid,
      'name': name,
      'photoUrl': photoUrl,
      'description': description,
      'cost': cost,
      'uid': uid,
    };
  }

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> docMap = doc.data() as Map<String, dynamic>;
    return Product(
      pid: docMap['pid'],
      name: docMap['name'],
      photoUrl: docMap['photoUrl'],
      description: docMap['description'],
      cost: docMap['cost'],
      uid: docMap['uid'],
    );
  }
}
