import 'package:cloud_firestore/cloud_firestore.dart';

enum ProductCategory {
  clothes,
  furniture,
  jewellery,
  technology,
  others,
}

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
    required this.name,
    this.imgUrl,
    required this.description,
    required this.price,
    required this.sellerId,
    required this.category,
  });

  Product copyWith({
    String? id,
    String? name,
    String? imgUrl,
    String? description,
    double? price,
    String? sellerId,
    ProductCategory? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      description: description ?? this.description,
      price: price ?? this.price,
      sellerId: sellerId ?? this.sellerId,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'description': description,
      'price': price,
      'sellerId': sellerId,
      'category': category.name,
    };
  }

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      name: data['name'] ?? '',
      imgUrl: data['imgUrl'],
      description: data['description'] ?? '',
      price: (data['price'] as num?)?.toDouble() ?? 0.0,
      sellerId: data['sellerId'] ?? '',
      category: ProductCategory.values.firstWhere(
        (e) => e.name == data['category'],
        orElse: () => ProductCategory.others,
      ),
    );
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'] ?? '',
      imgUrl: map['imgUrl'],
      description: map['description'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      sellerId: map['sellerId'] ?? '',
      category: ProductCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => ProductCategory.others,
      ),
    );
  }
}
