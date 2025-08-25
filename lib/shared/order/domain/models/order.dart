import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';

enum OrderStatus {
  pending("pending"),
  delivered("delivered"),
  cancelled("cancelled");

  final String name;
  const OrderStatus(this.name);
}

class Order {
  final String id;
  final String buyerId;
  final String sellerId;
  final Product product;
  final DateTime orderDate;
  final DateTime? deliveryDate;
  final OrderStatus status;

  Order({
    required this.id,
    required this.buyerId,
    required this.product,
    required this.orderDate,
    this.deliveryDate,
    required this.status,
    required this.sellerId,
  });

  factory Order.fromMap(Map<String, dynamic> map, String id) {
    return Order(
      id: id,
      buyerId: map['buyerId'] ?? '',
      sellerId: map['sellerId'] ?? '',
      product: map['product'] != null
          ? Product.fromMap(Map<String, dynamic>.from(map['product']))
          : throw Exception('Order missing product'),
      orderDate: map['orderDate'] is Timestamp
          ? (map['orderDate'] as Timestamp).toDate()
          : DateTime.now(),

      deliveryDate: map['deliveryDate'] is Timestamp
          ? (map['deliveryDate'] as Timestamp).toDate()
          : null,
      status: OrderStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => OrderStatus.pending,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'buyerId': buyerId,
      'sellerId': sellerId,
      'product': product.toMap(),
      'orderDate': Timestamp.fromDate(orderDate),
      'deliveryDate': deliveryDate != null
          ? Timestamp.fromDate(deliveryDate!)
          : null,
      'status': status.name,
    };
  }

  Order copyWith({
    String? id,
    String? buyerId,
    String? sellerId,
    Product? product,
    DateTime? orderDate,
    DateTime? deliveryDate,
    OrderStatus? status,
  }) {
    return Order(
      id: id ?? this.id,
      buyerId: buyerId ?? this.buyerId,
      sellerId: sellerId ?? this.sellerId,
      product: product ?? this.product,
      orderDate: orderDate ?? this.orderDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      status: status ?? this.status,
    );
  }
}
