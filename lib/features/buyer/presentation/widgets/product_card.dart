import 'package:flutter/material.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
<<<<<<< HEAD
  final VoidCallback onAddToCart;

  const ProductCard(
      {super.key, required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.025),
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product Image
              Container(
                width: 98,
                height: 118,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    product.productImageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image,
                        color: Colors.grey[400],
                        size: screenWidth * 0.08,
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: screenWidth * 0.04),
              // Product Details
              Expanded(
                child: SizedBox(
                  height: 118, // Match image height
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        product.productName,
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * 0.005),
                          Text(
                            'ETB ${product.price.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: screenWidth * 0.038,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: -10,
            right: 5,
            child: GestureDetector(
              onTap: onAddToCart,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 247, 245, 248),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 5,
                      )
                    ]),
                child: const Icon(
                  Icons.shopping_cart,
                  color: Color.fromARGB(255, 11, 11, 11),
                  size: 24,
                ),
              ),
            ),
          ),
        ],
=======
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: (product.imgUrl ?? '').startsWith('http')
                    ? Image.network(
                        product.imgUrl ?? '',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.error),
                          );
                        },
                      )
                    : Image.asset(
                        product.imgUrl ?? '',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.error),
                          );
                        },
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "ETB ${product.price}",
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
>>>>>>> origin
      ),
    );
  }
}
