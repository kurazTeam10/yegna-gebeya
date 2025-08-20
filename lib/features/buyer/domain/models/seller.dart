import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/features/buyer/domain/models/user.dart';

class Seller extends User {
  final String phone;

  Seller({
    required super.userId,
    required super.email,
    required super.fullName,
    required super.imgUrl,
    required this.phone,
  });

  factory Seller.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> docMap = doc.data() as Map<String, dynamic>;
    return Seller(
      userId: docMap['userId'] ?? '',
      email: docMap['email'] ?? '',
      fullName: docMap['fullName'] ?? '',
      imgUrl: docMap['imgUrl'] ?? '',
      phone: docMap['phone'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'email': email,
      'fullName': fullName,
      'imgUrl': imgUrl,
      'phone': phone,
    };
  }
}
