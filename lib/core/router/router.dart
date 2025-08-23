import 'dart:developer';

import 'package:go_router/go_router.dart';
import 'package:yegna_gebeya/core/router/routes.dart';
import 'package:yegna_gebeya/features/auth/presentation/pages/sign_in_page.dart';
import 'package:yegna_gebeya/features/auth/presentation/pages/sign_up_page.dart';
import 'package:yegna_gebeya/features/landing/presentation/pages/landing_page.dart';
import 'package:yegna_gebeya/features/profile/presentation/pages/profile_page.dart';
import 'package:yegna_gebeya/features/seller/order/presentation/pages/orders_page.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/pages/product_page.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/pages/product_upload_page.dart';
import 'package:yegna_gebeya/shared/domain/models/product.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: Routes.landigPage,
      builder: (context, state) => LandingPage(),
    ),
    GoRoute(path: Routes.signUp, builder: (context, state) => SignUpPage()),
    GoRoute(path: Routes.signIn, builder: (context, state) => SignInPage()),

    GoRoute(path: Routes.orders, builder: (context, state) => OrderPage()),
    GoRoute(
      path: Routes.sellerProfile,
      builder: ((context, state) => ProfilePage()),
    ),
    GoRoute(
      path: Routes.products,
      builder: ((context, state) => ProductPage()),
    ),
    GoRoute(
      path: Routes.productUpload,
      builder: (context, state) {
        log(state.extra.toString());
        return ProductUploadPage(productToBeEditted: state.extra as Product?);
      },
    ),
  ],
);
