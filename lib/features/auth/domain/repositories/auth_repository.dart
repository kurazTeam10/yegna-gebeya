import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
  );
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  );
  const AuthRepository();
}
