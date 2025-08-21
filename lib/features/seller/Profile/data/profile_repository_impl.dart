import '../domain/models/profile.dart';
import '../domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<Profile> getProfile(String userId) async {
    
    await Future.delayed(const Duration(milliseconds: 500));
    return Profile(
      id: userId,
      name: "John Doe",
      email: "johndoe@gmail.com",
      phone: "+2517479262",
      additionalPhone: "+251716489722",
      avatarUrl: "https://i.pravatar.cc/150?img=3",
    );
  }
}
