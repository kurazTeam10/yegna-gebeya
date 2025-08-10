import 'package:yegna_gebeya/core/shared/models/product.dart';

class Order {
  final List<Product> products;
  final DateTime timestamp;

  Order({required this.products, required this.timestamp});

}