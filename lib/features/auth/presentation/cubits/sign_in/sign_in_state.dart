import 'package:firebase_auth/firebase_auth.dart';
import 'package:yegna_gebeya/shared/domain/models/user.dart' as user;

abstract class SignInState {
  final UserCredential? cred;
  final String? errorMessage;
  const SignInState({required this.cred, required this.errorMessage});
}

class SignInInitial extends SignInState {
  const SignInInitial({super.cred, super.errorMessage});
}

class SignInLoading extends SignInState {
  const SignInLoading({super.cred, super.errorMessage});
}

class SignInSuccess extends SignInState {
  user.User appUser;
  SignInSuccess({super.cred, super.errorMessage, required this.appUser});
}

class SignInFailure extends SignInState {
  const SignInFailure({super.cred, super.errorMessage});
}
