abstract class User {
  final String uid;
  final String email;
  final String fullName;
  final String role;

  const User({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.role,
  });

  Map<String, dynamic> toMap() {
    return {'uid': uid, 'email': email, 'fullName': fullName, 'role': role};
  }
}
