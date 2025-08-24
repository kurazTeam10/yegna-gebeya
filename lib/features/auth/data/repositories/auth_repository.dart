import 'package:firebase_auth/firebase_auth.dart';
import 'package:yegna_gebeya/features/auth/domain/repositories/auth_repository.dart';
import 'package:yegna_gebeya/shared/domain/repositories/user_repository.dart';
import 'package:yegna_gebeya/shared/domain/models/user.dart' as userModel;

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth firebaseAuth;
  final UserRepository repository;
  const AuthRepositoryImpl({
    required this.firebaseAuth,
    required this.repository,
  });
  @override
  Future<UserCredential> signUpWithEmailAndPassword({
    required String displayName,
    required String email,
    required String password,
    required userModel.UserRole role,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) throw Exception('User creation failed');
      await user.updateDisplayName(displayName);
      await user.reload();
      final updatedUser = firebaseAuth.currentUser;
      if (updatedUser == null) throw Exception('User reload failed');
      await repository.registerUser(
        user: userModel.User.fromFirebaseAuthUser(
          user: updatedUser,
          role: role,
        ),
      );
      return credential;
    } catch (e) {
      // Handle or log error
      rethrow;
    }
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
