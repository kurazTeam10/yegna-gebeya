import 'package:firebase_auth/firebase_auth.dart';
import 'package:yegna_gebeya/shared/domain/models/user.dart';

abstract class AuthRepository {
  Future<UserCredential> signUpWithEmailAndPassword({
    required String displayName,
    required String email,
    required String password,
    required UserRole role,
  });
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  );
  const AuthRepository();
}
