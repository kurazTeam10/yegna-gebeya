import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yegna_gebeya/core/router/routes.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/cubits/product_upload/product_upload_cubit.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/cubits/product_upload/product_upload_state.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: () {
        context.go(Routes.productUpload, extra: product);
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: height * 0.01),
            width: width * 0.9,
            height: height * 0.15,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(1, 1),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: height * 0.12,
                  margin: EdgeInsets.all(width * 0.02),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(product.imgUrl!),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: SizedBox(
                          width: width * 0.5,
                          child: Text(
                            product.name,
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
                      ),
                      SizedBox(
                        width: width * 0.5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "ETB ${product.price.toString()}",
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
