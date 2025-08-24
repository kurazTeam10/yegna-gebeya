import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:yegna_gebeya/shared/domain/models/user.dart';
import 'package:yegna_gebeya/shared/domain/repositories/image_repository.dart';
import 'package:yegna_gebeya/shared/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final firebase_auth.FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final ImageRepository imageRepository;

  UserRepositoryImpl({
    required this.imageRepository,
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<User> getCurrentUserInfo() async {
    try {
      final userMap = await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get();
      final user = User.fromMap(userMap.data()!);
      return user;
    } on FirebaseException catch (e) {
      throw (Exception("Error getting current user information $e"));
    }
  }

  @override
  Future<void> setCurrentUserInfo({
    required User curUser,
    required User newUser,
  }) async {
    try {
      final userMap = newUser.toMap();
      await firebaseFirestore
          .collection('users')
          .doc(curUser.id.trim())
          .update(userMap);

      if (curUser.role.name == 'buyer') {
        await firebaseFirestore
            .collection('buyers')
            .doc(curUser.id)
            .update(userMap);
      } else if (curUser.role.name == 'seller') {
        await firebaseFirestore
            .collection('sellers')
            .doc(curUser.id)
            .update(userMap);
      }
    } catch (e) {
      throw (Exception('Error updating user information: $e'));
    }
  }

  @override
  Future<User> registerUser({required User user}) async {
    return firebaseFirestore.runTransaction((transaction) async {
      final userMap = user.toMap();
      final userDoc = firebaseFirestore.collection('users').doc(user.id);
      transaction.set(userDoc, userMap);
      if (user.role.name == 'buyer') {
        final buyerDoc = firebaseFirestore.collection('buyers').doc(user.id);
        transaction.set(buyerDoc, userMap);
      } else if (user.role.name == 'seller') {
        final sellerDoc = firebaseFirestore.collection('sellers').doc(user.id);
        transaction.set(sellerDoc, userMap);
      }
      return user;
    });
  }
}
