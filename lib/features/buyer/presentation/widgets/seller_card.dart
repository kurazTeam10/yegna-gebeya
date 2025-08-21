import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yegna_gebeya/features/buyer/domain/models/seller.dart';

class SellerCard extends StatelessWidget {
  final Seller seller;

  const SellerCard({super.key, required this.seller});

  int _parseRating(String rating) {
    int starCount = '⭐'.allMatches(rating).length;
    if (starCount > 0) return starCount.clamp(0, 5);

    final numMatch = RegExp(r'(\d+(?:\.\d+)?)').firstMatch(rating);
    if (numMatch != null) {
      double ratingValue = double.tryParse(numMatch.group(1)!) ?? 0;
      return ratingValue.round().clamp(0, 5);
    }

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return Container(
      height: 99,
      margin: EdgeInsets.only(bottom: screenSize.height * 0.015),
      decoration: BoxDecoration(
        color: const Color(0x128D00DE),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(screenWidth * 0.04),
        onTap: () {
          GoRouter.of(context).go('/sellerProfile/${seller.id}');
        },
        leading: CircleAvatar(
          radius: screenWidth * 0.075,
          backgroundColor: Colors.grey[300],
          backgroundImage:
              seller.imgUrl.isNotEmpty ? NetworkImage(seller.imgUrl) : null,
          child: seller.imgUrl.isEmpty
              ? Icon(
                  Icons.person,
                  size: screenWidth * 0.075,
                  color: Colors.grey,
                )
              : null,
          onBackgroundImageError: (exception, stackTrace) {},
        ),
        title: Text(
          seller.fullName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.04,
            color: Colors.black87,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: screenWidth * 0.04,
        ),
      ),
    );
  }
}
