import 'package:cloud_firestore/cloud_firestore.dart';

enum ProductCategory {
  clothesForMen,
  clothesForWomen,
  furniture,
  jewellery,
  technology,
  others,
}

class Product {
  final String? productId;
  final String productName;
  final String productImageUrl;
  final String productDescription;
  final double price;
  final String sellerId;
  final ProductCategory category;

  Product({
    this.productId,
    required this.productImageUrl,
    required this.productName,
    required this.sellerId,
    required this.productDescription,
    required this.category,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productImageUrl': productImageUrl,
      'productName': productName,
      'sellerId': sellerId,
      'productDescription': productDescription,
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
      productId: map['productId'],
      productImageUrl: map['productImageUrl'],
      productName: map['productName'],
      sellerId: map['sellerId'],
      productDescription: map['productDescription'],
      category: ProductCategory.values.firstWhere(
        (e) => e.name == map['category'],
        orElse: () => ProductCategory.others,
      ),
      price: map['price'],
    );
  }
}
