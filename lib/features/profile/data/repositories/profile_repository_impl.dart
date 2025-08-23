import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cross_file/cross_file.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:http/http.dart' as http;
import 'package:yegna_gebeya/shared/domain/models/user.dart';
import 'dart:convert';

import '../../domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final firebaseAuth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  ProfileRepositoryImpl({
    required firebaseAuth.FirebaseAuth firebaseAuth,
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
  Future<void> setCurrentUserInfo(
    User curUser,
    String fullName,
    String phoneNo,
    XFile? image,
  ) async {
    try {
      // Make sure to update both buyer/seller collection, user collection AND firbase Authdata
      String imgUrl = curUser.phoneNo;
      if (image != null) {
        imgUrl = await uploadImage(image);
      }

      final userMap = curUser.toMap();
      userMap['fullName'] = fullName;
      userMap['phoneNo'] = phoneNo;
      userMap['imgUrl'] = imgUrl;

      final uid = _firebaseAuth.currentUser!.uid;

      await _firebaseAuth.currentUser!.updateDisplayName(fullName);
      // await _firebaseAuth.currentUser!.updatePhoneNumber(phoneNo);
      await _firebaseAuth.currentUser!.updatePhotoURL(imgUrl);

      await _firebaseFirestore.collection('users').doc(uid).update(userMap);

      if (curUser.role.name == 'buyer') {
        await _firebaseFirestore.collection('buyers').doc(uid).update(userMap);
      } else if (curUser.role.name == 'seller') {
        await _firebaseFirestore.collection('sellers').doc(uid).update(userMap);
      }
    } catch (e) {
      throw (Exception('Error updating user information $e'));
    }
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
