class ProductEntity {
  final String id;
  final String sellerId;
  final String title;
  final String description;
  final double price;
  final int stock;
  final List<String> images;

  const ProductEntity({
    required this.id,
    required this.sellerId,
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
    required this.images,
  });
}
