import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yegna_gebeya/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  const AuthRepositoryImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserCredential> signUpWithEmailAndPassword(
    String email,
    String password,
    String role,
    String fullName,
  ) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Save user info in Firestore
    await firestore.collection("users").doc(credential.user!.uid).set({
      "uid": credential.user!.uid,
      "email": email,
      "fullName": fullName,
      "role": role,
      "createdAt": FieldValue.serverTimestamp(),
    });

    return credential;
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
