import 'package:flutter/material.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/widget/product_card.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8FF),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.08,
        ),
        children: [
          ProductCard(
            imageUrl: 'assets/images/cloth01.jpg',
            productName: 'Sleeveless Pink Ruffle Collar Dress',
            quantity: '2 left',
            price: 'ETB 4,890',
            onEdit: () {},
          ),
          ProductCard(
            imageUrl: 'assets/images/cloth3.jpg',
            productName: 'Sleeveless Pink Ruffle Collar Dress',
            quantity: '2 left',
            price: 'ETB 4,890',
            onEdit: () {},
          ),
          ProductCard(
            imageUrl: 'assets/images/cloth10.jpg',
            productName: 'Sleeveless Pink Ruffle Collar Dress',
            quantity: '2 left',
            price: 'ETB 4,890',
            onEdit: () {},
          ),
          ProductCard(
            imageUrl: 'assets/images/cloth6.jpg',
            productName: 'Sleeveless Pink Ruffle Collar Dress',
            quantity: '2 left',
            price: 'ETB 4,890',
            onEdit: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF433CFF),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
