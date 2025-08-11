import 'package:cloud_firestore/cloud_firestore.dart';

class Seller {
  final String id;
  final String fullName;
  final String email;

  const Seller({
    required this.id,
    required this.fullName,
    required this.email,
  });

  factory Seller.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return Seller(
      id: doc.id,
      fullName: data['fullName'] ?? '',
      email: data['email'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'fullName': fullName,
      'email': email,
    };
  }
}
