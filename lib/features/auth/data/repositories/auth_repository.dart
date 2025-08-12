import 'package:firebase_auth/firebase_auth.dart';
import 'package:yegna_gebeya/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth firebaseAuth;
  const AuthRepositoryImpl({required this.firebaseAuth});
  @override
  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credintial = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credintial;
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  }
}
