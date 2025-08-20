import 'package:yegna_gebeya/shared/domain/models/user.dart';

class Buyer extends User {
  Buyer({
    required super.id,
    required super.email,
    required super.fullName,
    required super.imgUrl,
    required super.createdAt,
  }) : super(role: UserRole.buyer);
}
