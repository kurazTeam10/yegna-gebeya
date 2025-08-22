import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/shared/domain/models/user.dart';
import 'package:yegna_gebeya/shared/domain/repositories/user_repository.dart';

class UserRepositoryIml extends UserRepository {
  final FirebaseFirestore firestore;

  UserRepositoryIml({required this.firestore});

  @override
  Future<void> saveUser(User user) async {
    await firestore.collection('users').doc(user.id).set(user.toMap());
    if (user.role == UserRole.buyer) {
      await firestore.collection('buyers').doc(user.id).set(user.toMap());
    } else if (user.role == UserRole.seller) {
      await firestore.collection('sellers').doc(user.id).set(user.toMap());
    }
  }

  @override
  Future<UserRole?> getUserRole(String userId) async {
    final doc = await firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      final role = doc.data()?['role'] as String?;
      return role == 'seller'
          ? UserRole.seller
          : role == 'buyer'
          ? UserRole.buyer
          : null;
    }
    return null;
  }
}
