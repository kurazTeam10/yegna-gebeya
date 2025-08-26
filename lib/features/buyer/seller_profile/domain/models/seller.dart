import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/shared/domain/models/user.dart';

class Seller extends User {
  Seller(
      {required super.id,
      required super.email,
      required super.fullName,
      required super.imgUrl,
      required super.createdAt,
      required super.phoneNo})
      : super(role: UserRole.seller);

  factory Seller.fromFirestore(DocumentSnapshot doc) {
    final Map<String, dynamic> docMap = doc.data() as Map<String, dynamic>;
    return Seller(
      phoneNo: docMap['phoneNo'],
      id: docMap['uid'] ?? '',
      email: docMap['email'] ?? '',
      fullName: docMap['fullName'] ?? '',
      imgUrl: docMap['imgUrl'] ?? '',
      createdAt: (docMap['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': id,
      'email': email,
      'fullName': fullName,
      'imgUrl': imgUrl,
      'phone': phoneNo,
      'role': role.toString(),
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
