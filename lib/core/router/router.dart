import 'package:go_router/go_router.dart';
import 'package:yegna_gebeya/core/router/routes.dart';
import 'package:yegna_gebeya/features/auth/presentation/pages/sign_in_page.dart';
import 'package:yegna_gebeya/features/auth/presentation/pages/sign_up_page.dart';
import 'package:yegna_gebeya/features/landing/presentation/pages/landing_page.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(
      path: Routes.landigPage,
      builder: (context, state) => LandingPage(),
    ),
    GoRoute(path: Routes.signUp, builder: (context, state) => SignUpPage()),
    GoRoute(path: Routes.signIn, builder: (context, state) => SignInPage()),
  ],
);
