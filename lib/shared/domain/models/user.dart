import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum UserRole {
  seller('seller'),
  buyer('buyer');

  final String name;
  const UserRole(this.name);

  @override
  String toString() => name;
}

class User {
  final String id;
  final String email;
  final String fullName;
  final String imgUrl;
  final UserRole role;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.imgUrl,
    required this.role,
    required this.createdAt,
  });

  factory User.fromFirebaseAuthUser({
    required firebaseAuth.User user,
    required UserRole role,
    DateTime? createdAt,
  }) {
    return User(
      id: user.uid,
      email: user.email ?? '',
      fullName: user.displayName ?? '',
      imgUrl: user.photoURL ?? '',
      role: role,
      createdAt: createdAt ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'createdAt': Timestamp.fromDate(createdAt),
      'uid': id,
      'email': email,
      'fullName': fullName,
      'imgUrl': imgUrl,
      'role': role.toString(),
    };
  }
}
