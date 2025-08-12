import 'package:firebase_auth/firebase_auth.dart';

abstract class SignUpState {
  final UserCredential? cred;
  final String? errorMessage;

  const SignUpState({required this.cred, required this.errorMessage});
}

class SignUpInitial extends SignUpState {
  const SignUpInitial({super.cred, super.errorMessage});
}

class SignUpLoading extends SignUpState {
  const SignUpLoading({super.cred, super.errorMessage});
}

class SignUpSuccess extends SignUpState {
  const SignUpSuccess({super.cred, super.errorMessage});
}

class SignUpFailure extends SignUpState {
  const SignUpFailure({super.cred, super.errorMessage});
}
