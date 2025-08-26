import 'package:go_router/go_router.dart';
import 'package:yegna_gebeya/core/router/routes.dart';
import 'package:yegna_gebeya/features/auth/presentation/pages/sign_in_page.dart';
import 'package:yegna_gebeya/features/auth/presentation/pages/sign_up_page.dart';
import 'package:yegna_gebeya/features/buyer/home/presentation/pages/home.dart';
import 'package:yegna_gebeya/features/buyer/cart/presentation/pages/checkout_page.dart';
import 'package:yegna_gebeya/features/buyer/order/presentation/pages/order_history_page.dart';
import 'package:yegna_gebeya/features/buyer/seller_profile/presentation/pages/seller_list_page.dart';
import 'package:yegna_gebeya/features/buyer/seller_profile/presentation/pages/seller_profile_page.dart';
import 'package:yegna_gebeya/features/landing/presentation/pages/landing_page.dart';
import 'package:yegna_gebeya/features/seller/order/presentation/pages/orders_page.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/pages/product_page.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/pages/product_upload_page.dart';
import 'package:yegna_gebeya/shared/domain/models/user.dart';
import 'package:yegna_gebeya/shared/profile/presentation/pages/profile_page.dart';

final goRouter = GoRouter(
  routes: [
    //common
    GoRoute(
      path: Routes.landingPage,
      builder: (context, state) => LandingPage(),
    ),
    GoRoute(path: Routes.signUp, builder: (context, state) => SignUpPage()),
    GoRoute(path: Routes.signIn, builder: (context, state) => SignInPage()),
    GoRoute(
      path: Routes.orderHistory,
      builder: (context, state) => OrderHistoryPage(
        user: state.extra as User,
      ),
    ),
    GoRoute(
      path: Routes.profile,
      builder: ((context, state) =>
          ProfilePage(currentUser: state.extra! as User)),
    ),

    //seller
    GoRoute(
      path: Routes.orders,
      builder: (context, state) => OrderPage(currentUser: state.extra as User),
    ),
    GoRoute(
      path: Routes.products,
      builder: ((context, state) =>
          ProductPage(currentUser: state.extra! as User)),
    ),
    GoRoute(
      path: Routes.productUpload,
      builder: (context, state) {
        return ProductUploadPage(params: state.extra as Map<String, dynamic>);
      },
    ),

    //buyer
    GoRoute(
        path: Routes.checkOut,
        builder: (context, state) =>
            CheckoutPage(params: state.extra as Map<String, dynamic>)),
    GoRoute(
      path: Routes.buyerHome,
      builder: (context, state) {
        return Home(user: state.extra as User);
      },
    ),
    GoRoute(
      path: Routes.sellerList,
      builder: (context, state) => SellerListPage(
        user: state.extra as User,
      ),
    ),
    GoRoute(
      path: Routes.sellerProfile,
      builder: (context, state) {
        return SellerProfilePage(params: state.extra as Map<String, dynamic>);
      },
    ),
  ],
);
