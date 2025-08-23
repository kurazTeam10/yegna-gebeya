import 'package:cross_file/cross_file.dart';
import 'package:yegna_gebeya/shared/domain/models/user.dart';

abstract class ProfileRepository {
  Future<User> getCurrentUserInfo();
  Future<User> registerUser({required User user});
  Future<void> setCurrentUserInfo({
    required User curUser,
    required User newUser,
    XFile? image,
  });
}

//get current user info 
//update current user info