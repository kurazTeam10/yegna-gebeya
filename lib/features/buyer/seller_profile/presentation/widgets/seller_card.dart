import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yegna_gebeya/core/router/routes.dart';
import 'package:yegna_gebeya/features/buyer/seller_profile/domain/models/seller.dart';

class SellerCard extends StatelessWidget {
  final Seller seller;

  const SellerCard({super.key, required this.seller});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return Container(
      height: 99,
      margin: EdgeInsets.only(bottom: screenSize.height * 0.015),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryFixedDim,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(screenWidth * 0.04),
        onTap: () {
          context.go(Routes.sellerProfile,
              extra: {"sellerId": seller.id, "user": seller});
        },
        leading: CircleAvatar(
          radius: screenWidth * 0.075,
          backgroundColor: Colors.grey[300],
          child: (seller.imgUrl != null && seller.imgUrl!.isNotEmpty)
              ? ClipOval(
                  child: Image.network(
                    seller.imgUrl!,
                    width: screenWidth * 0.15,
                    height: screenWidth * 0.15,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.person,
                      size: screenWidth * 0.075,
                      color: Colors.grey,
                    ),
                  ),
                )
              : Icon(
                  Icons.person,
                  size: screenWidth * 0.075,
                  color: Colors.grey,
                ),
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
