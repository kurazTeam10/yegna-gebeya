import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yegna_gebeya/features/buyer/data/models/user.dart';

class Seller extends User {
  Seller({required super.uid, required super.email, required super.fullName})
    : super(role: 'seller');

  factory Seller.fromFirestore(DocumentSnapshot doc) {
    final Map<String,dynamic> docMap = doc.data() as Map<String, dynamic>;
    return Seller(uid: docMap['uid'], email: docMap['email'], fullName: docMap['fullName']);
  }
}
