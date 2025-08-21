import 'package:yegna_gebeya/shared/domain/models/user.dart';

class Seller extends User {
  double? rating;
  int? reviewCount;

  Seller({
    required super.id,
    required super.email,
    required super.fullName,
    required super.imgUrl,
    super.role = UserRole.seller,
    required super.createdAt,
    required super.phoneNo,
    this.rating,
    this.reviewCount,
    
  });
  @override
  Map<String, dynamic> toMap() {
    return {
      'uid': id,
      'email': email,
      'fullName': fullName,
      'imgUrl': imgUrl,
      'phoneNo': phoneNo,
      'rating': rating,
      'reviewCount': reviewCount,
      'createdAt': createdAt,
    };
  }

  factory Seller.fromMap({required Map<String, dynamic> map}) {
    return Seller(
      id: map['id'] ?? map['uid'],
      email: map['email'],
      fullName: map['fullName'],
      imgUrl: map['imgUrl'],
      createdAt: map['createdAt'],
      phoneNo: map['phoneNo'],
      rating: map['rating'],
      reviewCount: map['reviewCount'],
    );
  }
}
