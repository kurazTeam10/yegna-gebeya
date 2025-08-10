import 'package:yegna_gebeya/core/shared/models/user.dart';

class Seller extends User {
  Seller({required super.uid, required super.email, required super.fullName})
    : super(role: 'seller');
}
