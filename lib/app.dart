import 'package:flutter/material.dart';
import 'package:yegna_gebeya/core/locator.dart';
import 'package:yegna_gebeya/core/router/router.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_in/sign_in_cubit.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubits/sign_up/sign_up_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/features/buyer/presentation/cubit/product_cubit.dart';
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SignUpCubit>()),
        BlocProvider(create: (context) => getIt<SignInCubit>()),
        BlocProvider(create: (context) => getIt<ProductCubit>()), // 👈 ADD THIS
      ],
      child: MaterialApp.router(
        routerConfig: goRouter,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFFFFFFF),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF8D00DE),
            primary: const Color(0xFF8D00DE),
          ),
          useMaterial3: true,
          textTheme: ThemeData.light().textTheme.copyWith(
            displaySmall: const TextStyle(
              color: Color(0xFF000000),
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
