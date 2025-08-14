import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/features/buyer/domain/models/user.dart';

class Seller extends User {
  Seller({
    required super.userId,
    required super.email,
    required super.fullName,
    required super.imgUrl,
  });

  factory Seller.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> docMap = doc.data() as Map<String, dynamic>;
    return Seller(
      userId: docMap['userId'],
      email: docMap['email'],
      fullName: docMap['fullName'],
      imgUrl: docMap['imgUrl'],
    );
  }
}
