import 'package:cloud_firestore/cloud_firestore.dart';

enum ProductCategory { clothes, furniture, jewellery, technology, others }

class Product {
  final String? id;
  final String name;
  final String imgUrl;
  final String description;
  final double price;
  final String sellerId;
  final ProductCategory category;

  Product({
    this.id,
    required this.imgUrl,
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
      id: map['productId'],
      imgUrl: map['productImageUrl'],
      name: map['productName'],
      sellerId: map['sellerId'],
      description: map['productDescription'],
      category: ProductCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => ProductCategory.others,
      ),
      price: map['price'],
    );
  }
  Product copyWith({
    String? imgUrl,
    String? name,
    String? sellerId,
    String? description,
    ProductCategory? category,
    double? price,
  }) {
    return Product(
      id: id,
      imgUrl: imgUrl ?? this.imgUrl,
      name: name ?? this.name,
      sellerId: sellerId ?? this.sellerId,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
    );
  }
}
