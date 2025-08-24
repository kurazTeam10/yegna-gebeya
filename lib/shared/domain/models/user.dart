import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
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
  final String phoneNo;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.imgUrl,
    required this.role,
    required this.createdAt,
    required this.phoneNo,
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
      phoneNo: user.phoneNumber ?? '',
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
      'phoneNo': phoneNo,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      imgUrl: map['imgUrl'],
      role: UserRole.values.firstWhere(
        (e) => e.name == map['role'],
        orElse: () => UserRole.buyer,
      ),
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      phoneNo: map['phoneNo'],
    );
  }
  User copyWith({
    String? id,
    String? email,
    String? fullName,
    String? imgUrl,
    UserRole? role,
    DateTime? createdAt,
    String? phoneNo,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      imgUrl: imgUrl ?? this.imgUrl,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      phoneNo: phoneNo ?? this.phoneNo,
    );
  }
}
