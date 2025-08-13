import 'package:yegna_gebeya/features/buyer/domain/models/user.dart';

class Buyer extends User {
  Buyer({required super.id, required super.email, required super.name})
    : super(role: 'buyer');
}
