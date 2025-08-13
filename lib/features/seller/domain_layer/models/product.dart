enum ProductCategory {
  clothesForMen,
  clothesForWomen,
  furniture,
  jewellery,
  technology,
  others,
}

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final ProductCategory category;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });
}
