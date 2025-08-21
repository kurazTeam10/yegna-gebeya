import 'package:go_router/go_router.dart';
import 'package:yegna_gebeya/core/router/routes.dart';
import 'package:yegna_gebeya/features/auth/presentation/pages/sign_in_page.dart';
import 'package:yegna_gebeya/features/auth/presentation/pages/sign_up_page.dart';
import 'package:yegna_gebeya/features/buyer/presentation/pages/seller_list_page.dart';
import 'package:yegna_gebeya/features/buyer/presentation/pages/seller_profile_page.dart';
import 'package:yegna_gebeya/features/landing/presentation/pages/landing_page.dart';

final goRouter = GoRouter(
  initialLocation: Routes.landingPage,
  routes: [
    GoRoute(
      path: Routes.sellerList,
      builder: (context, state) => const SellerListPage(),
    ),
    GoRoute(
      path: Routes.sellerProfile,
      builder: (context, state) {
        final sellerId = state.pathParameters['sellerId']!;
        return SellerProfilePage(sellerId: sellerId);
      },
    ),
    GoRoute(
        path: Routes.signUp, builder: (context, state) => const SignUpPage()),
    GoRoute(
        path: Routes.signIn, builder: (context, state) => const SignInPage()),
    GoRoute(
      path: Routes.landingPage,
      builder: (context, state) => const LandingPage(),
    ),
  ],
);
