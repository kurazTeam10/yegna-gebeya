class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String sellerId;
  final List<String> imageUrls;  

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.sellerId,
    required this.imageUrls,
  });
}
