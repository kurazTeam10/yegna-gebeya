import 'package:flutter/material.dart';
import 'package:yegna_gebeya/core/locator.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubit/sign_in_cubit.dart';
import 'package:yegna_gebeya/features/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yegna_gebeya/features/auth/presentation/pages/sign_in_page.dart';
import 'package:yegna_gebeya/features/auth/presentation/pages/sign_up_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SignUpCubit>()),
        BlocProvider(create: (context) => getIt<SignInCubit>()),
      ],
      child: MaterialApp(home: SignUpPage()),
    );
  }
}
