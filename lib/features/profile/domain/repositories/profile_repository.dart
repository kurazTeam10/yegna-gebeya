import 'package:cross_file/cross_file.dart';
import 'package:yegna_gebeya/shared/domain/models/user.dart';

abstract class ProfileRepository {
  Future<User> getCurrentUserInfo();
  Future<void> setCurrentUserInfo(
    User curUser,
    String fullName,
    String phoneNo,
    XFile? image,
  );
}

//get current user info 
//update current user info