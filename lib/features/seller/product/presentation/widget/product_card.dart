import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String quantity;
  final String price;
  final VoidCallback onEdit;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.quantity,
    required this.price,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.01),
      width: width * 0.9,
      height: height * 0.2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                width: width * 0.25,
                height: height * 0.18,
                margin: EdgeInsets.all(width * 0.02),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          productName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontFamily: 'SF Compact',
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.04,
                            color: Color(0xFF333333),
                          ),
                        ),
                      ),
                      Text(
                        quantity,
                        style: TextStyle(
                          fontFamily: 'SF Compact',
                          fontWeight: FontWeight.w500,
                          fontSize: width * 0.04,
                          color: Color(0xFFD08FF5),
                        ),
                      ),
                      Text(
                        price,
                        style: TextStyle(
                          fontFamily: 'SF Compact',
                          fontWeight: FontWeight.w600,
                          fontSize: width * 0.04,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: height * 0.02,
            right: width * 0.04,
            child: GestureDetector(
              onTap: onEdit,
              child: Container(
                width: width * 0.16,
                height: height * 0.035,
                decoration: BoxDecoration(
                  color: const Color(0xFF433CFF).withOpacity(0.7),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'edit',
                    style: TextStyle(
                      fontFamily: 'SF Compact',
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.035,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
