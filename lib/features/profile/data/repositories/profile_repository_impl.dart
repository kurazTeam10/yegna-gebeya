import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_file/cross_file.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:http/http.dart' as http;
import 'package:yegna_gebeya/shared/domain/models/user.dart';
import 'dart:convert';

import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  ProfileRepositoryImpl({
    required firebase_auth.FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  }) : _firebaseAuth = firebaseAuth,
       _firebaseFirestore = firebaseFirestore;

  @override
  Future<User> getCurrentUserInfo() async {
    try {
      final userMap = await _firebaseFirestore
          .collection('users')
          .doc(_firebaseAuth.currentUser!.uid)
          .get();
      final user = User.fromMap(userMap.data()!);
      return user;
    } on FirebaseException catch (e) {
      throw (Exception("Error getting current user information $e"));
    }
  }

  @override
  Future<void> setCurrentUserInfo({
    required User curUser,
    required User newUser,
    XFile? image,
  }) async {
    try {
      if (image != null) {
        String imgUrl = await uploadImage(image);
        await _firebaseAuth.currentUser!.updatePhotoURL(imgUrl);
      }

      final userMap = newUser.toMap();

      await _firebaseFirestore
          .collection('users')
          .doc(curUser.id.trim())
          .update(userMap);

      if (curUser.role.name == 'buyer') {
        await _firebaseFirestore
            .collection('buyers')
            .doc(curUser.id)
            .update(userMap);
      } else if (curUser.role.name == 'seller') {
        await _firebaseFirestore
            .collection('sellers')
            .doc(curUser.id)
            .update(userMap);
      }
    } catch (e) {
      throw (Exception('Error updating user information: $e'));
    }
  }

  @override
  Future<User> registerUser({required User user}) async {
    return _firebaseFirestore.runTransaction((transaction) async {
      final userMap = user.toMap();
      final userDoc = _firebaseFirestore.collection('users').doc(user.id);
      transaction.set(userDoc, userMap);
      if (user.role.name == 'buyer') {
        final buyerDoc = _firebaseFirestore.collection('buyers').doc(user.id);
        transaction.set(buyerDoc, userMap);
      } else if (user.role.name == 'seller') {
        final sellerDoc = _firebaseFirestore.collection('sellers').doc(user.id);
        transaction.set(sellerDoc, userMap);
      }
      return user;
    });
  }

  Future<String> uploadImage(XFile imageFile) async {
    try {
      final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/<cloud_name>/upload',
      );
      final request = http.MultipartRequest('POST', url);
      request.fields['upload_preset'] = '<preset_name>';
      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );
      final response = await request.send();
      if (response.statusCode != 200) {
        throw (Exception('Failed to update image'));
      }
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);
      final jsonMap = jsonDecode(responseString);
      return jsonMap['url'];
    } catch (e) {
      throw (Exception('$e'));
    }
  }
}
