import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/shared/domain/models/user.dart';
import 'package:yegna_gebeya/shared/domain/repositories/user_repository.dart';

class UserRepositoryIml extends UserRepository {
  final FirebaseFirestore firestore;

  UserRepositoryIml({required this.firestore});
  @override
  Future<void> saveUser(User user) async {
    await firestore.collection('users').doc(user.id).set(user.toMap());
  }
}
