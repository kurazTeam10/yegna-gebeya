class Profile {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? additionalPhone;
  final String avatarUrl;

  const Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.additionalPhone,
    required this.avatarUrl,
  });
}
