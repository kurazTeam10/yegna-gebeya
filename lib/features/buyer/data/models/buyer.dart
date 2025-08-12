import 'package:yegna_gebeya/features/buyer/data/models/user.dart';

class Buyer extends User {
  Buyer({required super.uid, required super.email, required super.fullName})
    : super(role: 'buyer');
}
