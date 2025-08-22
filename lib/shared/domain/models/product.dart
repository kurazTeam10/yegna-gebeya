
import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String? id; 
  final String? productImageUrl;
  final String? productName;
  final String? sellerId;
  final String? productDescription;
  final String category; 
  final double price;

  Product({
    this.id,
    this.productImageUrl,
    this.productName,
    this.sellerId,
    this.productDescription,
    required this.category,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productImageUrl': productImageUrl,
      'productName': productName,
      'sellerId': sellerId,
      'productDescription': productDescription,
      'category': category, 
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? map['productId'], 
      productImageUrl: map['productImageUrl'],
      productName: map['productName'],
      sellerId: map['sellerId'],
      productDescription: map['productDescription'],
      category: map['category'] ?? '', 
      price: (map['price'] ?? 0.0).toDouble(),
    );
  }
}