import 'package:firebase_auth/firebase_auth.dart';
import 'package:yegna_gebeya/shared/domain/models/user.dart';

abstract class SignInState {
  final UserCredential? cred;
  final String? errorMessage;
  final UserRole? role;

  const SignInState({
    required this.cred,
    required this.errorMessage,
    required this.role,
  });
}

class SignInInitial extends SignInState {
  const SignInInitial({super.cred, super.errorMessage, super.role});
}

class SignInLoading extends SignInState {
  const SignInLoading({super.cred, super.errorMessage, super.role});
}

class SignInSuccess extends SignInState {
  const SignInSuccess({super.cred, super.errorMessage, required super.role});
}

class SignInFailure extends SignInState {
  const SignInFailure({super.cred, super.errorMessage, super.role});
}
