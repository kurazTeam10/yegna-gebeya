import 'package:firebase_auth/firebase_auth.dart';

abstract class SignInState {
  final UserCredential? cred;
  final String? errorMessage;


  const SignInState({required this.cred, required this.errorMessage});
}

class LoginInitial extends SignInState{
  const LoginInitial({super.cred , super.errorMessage});
}

class LoginLoading extends SignInState{
  const LoginLoading({super.cred , super.errorMessage});
}

class LoginSuccess extends SignInState{
  const LoginSuccess({super.cred , super.errorMessage});
}

class LoginFailure extends SignInState{
  const LoginFailure({super.cred , super.errorMessage});
}