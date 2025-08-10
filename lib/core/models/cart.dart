import 'package:yegna_gebeya/core/models/product.dart';

class Cart {
  final String userId;
  final List<CartItem> items;

  const Cart({required this.userId, required this.items});
}

class CartItem {
  final Product product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});
}
