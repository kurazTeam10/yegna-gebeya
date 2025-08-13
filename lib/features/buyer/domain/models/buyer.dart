import 'package:yegna_gebeya/features/buyer/domain/models/user.dart';

class Buyer extends User {
  Buyer({
    required super.userId,
    required super.email,
    required super.fullName,
    required super.imgUrl,
  });
}
