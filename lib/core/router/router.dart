import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:yegna_gebeya/core/locator.dart';
import 'package:yegna_gebeya/core/router/routes.dart';
import 'package:yegna_gebeya/features/auth/presentation/pages/sign_in_page.dart';
import 'package:yegna_gebeya/features/auth/presentation/pages/sign_up_page.dart';
import 'package:yegna_gebeya/features/buyer/domain/repositories/buyer_repository.dart';
import 'package:yegna_gebeya/features/buyer/presentation/bloc/seller_list_bloc.dart';
import 'package:yegna_gebeya/features/buyer/presentation/bloc/seller_list_event.dart';
import 'package:yegna_gebeya/features/buyer/presentation/pages/seller_list_page.dart';
import 'package:yegna_gebeya/features/buyer/presentation/pages/seller_profile_page.dart';
import 'package:yegna_gebeya/features/landing/presentation/pages/landing_page.dart';

final goRouter = GoRouter(
  initialLocation: Routes.sellerList,
  routes: [
    GoRoute(
      path: Routes.sellerList,
      builder: (context, state) => BlocProvider(
        create: (context) => SellerListBloc(
          buyerRepository: getIt<BuyerRepository>(),
        )..add(FetchSellersEvent()),
        child: const SellerListPage(),
      ),
    ),
    GoRoute(
        path: Routes.signUp, builder: (context, state) => const SignUpPage()),
    GoRoute(
        path: Routes.signIn, builder: (context, state) => const SignInPage()),
    GoRoute(
      path: Routes.landingPage,
      builder: (context, state) => const LandingPage(),
    ),
    GoRoute(
      path: Routes.sellerProfile,
      builder: (context, state) {
        final sellerId = state.pathParameters['sellerId']!;
        return SellerProfilePage(sellerId: sellerId);
      },
    ),
  ],
);
