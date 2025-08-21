import '../models/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile(String userId);
}
