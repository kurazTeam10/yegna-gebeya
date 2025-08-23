class OrderModel {
  final String id;
  final String productName;
  final String imageUrl;
  final int quantity;
  final double price;
  final DateTime date;
  final String status;

  OrderModel({
    required this.id,
    required this.productName,
    required this.imageUrl,
    required this.quantity,
    required this.price,
    required this.date,
    required this.status,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map, String id) {
    return OrderModel(
      id: id,
      productName: map['productName'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      quantity: map['quantity'] ?? 0,
      price: (map['price'] ?? 0).toDouble(),
      date: map['date'] != null
          ? DateTime.tryParse(map['date']) ?? DateTime.now()
          : DateTime.now(),
      status: map['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'price': price,
      'date': date.toIso8601String(),
      'status': status,
    };
  }

  OrderModel copyWith({
    String? productName,
    String? imageUrl,
    int? quantity,
    double? price,
    DateTime? date,
    String? status,
  }) {
    return OrderModel(
      id: id,
      productName: productName ?? this.productName,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      date: date ?? this.date,
      status: status ?? this.status,
    );
  }
}
