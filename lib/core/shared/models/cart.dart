import 'package:yegna_gebeya/core/shared/models/product.dart';

class Cart {
  List<Product> products;

  Cart({List<Product>? products}) : products = products ?? <Product>[];

}