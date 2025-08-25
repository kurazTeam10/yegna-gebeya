
import 'package:cloud_firestore/cloud_firestore.dart';

enum ProductCategory { clothes, furniture, jewellery, technology, others }

class Product {
  final String? id;
  final String name;
  final String? imgUrl;
  final String description;
  final double price;
  final String sellerId;
  final ProductCategory category;

  Product({
    this.id,
    this.imgUrl,
    required this.name,
    required this.sellerId,
    required this.description,
    required this.category,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productImageUrl': imgUrl,
      'productName': name,
      'sellerId': sellerId,
      'productDescription': description,
      'category': category.name,
      'price': price,
    };
  }

  factory Product.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> docMap = doc.data() as Map<String, dynamic>;
    return Product.fromMap(docMap);
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
<<<<<<< HEAD
      productId: map['productId'],
      productImageUrl: map['productImageUrl'] ?? '',
      productName: map['productName'] ?? '',
      sellerId: map['sellerId'] ?? '',
      productDescription: map['productDescription'] ?? '',
=======
      id: map['id'],
      imgUrl: map['productImageUrl'],
      name: map['productName'],
      sellerId: map['sellerId'],
      description: map['productDescription'],
>>>>>>> origin
      category: ProductCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => ProductCategory.others,
      ),
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
    );
  }
  Product copyWith({
    String? id,
    String? imgUrl,
    String? name,
    String? sellerId,
    String? description,
    ProductCategory? category,
    double? price,
  }) {
    return Product(
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      name: name ?? this.name,
      sellerId: sellerId ?? this.sellerId,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
    );
  }
}