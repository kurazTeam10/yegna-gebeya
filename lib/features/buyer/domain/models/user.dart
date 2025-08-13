import 'package:yegna_gebeya/features/buyer/domain/models/order.dart';

abstract class User {
  final String userId;
  final String email;
  final String fullName;
  final String imgUrl;

  const User({
    required this.userId,
    required this.email,
    required this.fullName,
    required this.imgUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'fullName': fullName,
      'imgUrl': imgUrl,
    };
  }
}
