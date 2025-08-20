import 'package:yegna_gebeya/shared/domain/models/user.dart';

abstract class UserRepository {
  Future<void> saveUser(User user);
}
