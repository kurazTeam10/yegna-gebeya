import 'package:yegna_gebeya/shared/domain/models/user.dart';

abstract class UserRepository {
  Future<void> registerUser({required User user});
  Future<void> setCurrentUserInfo({
    required User curUser,
    required User newUser,
  });
  Future<User?> getCurrentUserInfo();
}
