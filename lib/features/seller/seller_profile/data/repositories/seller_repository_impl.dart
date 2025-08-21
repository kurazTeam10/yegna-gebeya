// import 'package:yegna_gebeya/features/seller/registration/domain/models/seller.dart';
// import 'package:yegna_gebeya/features/seller/registration/domain/repositories/seller_repository.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class SellerRepositoryImpl extends SellerRepository {
//   @override
//   /// Get seller info from Firestore
//   Future<Seller> getSellerInfo({required String sellerId}) async {
//     final doc = await FirebaseFirestore.instance
//         .collection('sellers')
//         .doc(sellerId)
//         .get();
//     if (!doc.exists) {
//       throw Exception('Seller not found');
//     }
//     return Seller.fromMap(map: doc.data()!);
//   }

//   @override
//   /// Register a new seller
//   Future<void> registerSeller({required Seller seller}) {
//     return FirebaseFirestore.instance
//         .collection('sellers')
//         .doc(seller.id)
//         .set(seller.toMap());
//   }

//   @override
//   /// Update seller information
//   Future<void> updateSellerInfo({
//     required String sellerId,
//     required Seller seller,
//   }) {
//     return FirebaseFirestore.instance
//         .collection('sellers')
//         .doc(sellerId)
//         .update(seller.toMap());
//   }
// }
