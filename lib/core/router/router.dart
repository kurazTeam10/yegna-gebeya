import 'package:go_router/go_router.dart';
import 'package:yegna_gebeya/core/router/routes.dart';
import 'package:yegna_gebeya/features/auth/presentation/pages/sign_in_page.dart';
import 'package:yegna_gebeya/features/auth/presentation/pages/sign_up_page.dart';
import 'package:yegna_gebeya/features/buyer/home/presentation/pages/home.dart';
import 'package:yegna_gebeya/features/landing/presentation/pages/landing_page.dart';
import 'package:yegna_gebeya/shared/domain/models/user.dart';
import 'package:yegna_gebeya/shared/profile/presentation/pages/profile_page.dart';
import 'package:yegna_gebeya/features/seller/order/presentation/pages/orders_page.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/pages/product_page.dart';
import 'package:yegna_gebeya/features/seller/product/presentation/pages/product_upload_page.dart';

final goRouter = GoRouter(
  routes: [
    //common
    GoRoute(
      path: Routes.landigPage,
      builder: (context, state) => LandingPage(),
    ),
    GoRoute(path: Routes.signUp, builder: (context, state) => SignUpPage()),
    GoRoute(path: Routes.signIn, builder: (context, state) => SignInPage()),
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
      path: Routes.buyerHome,
      builder: (context, state) {
        return Home(user: state.extra as User);
      },
    ),
  ],
);
