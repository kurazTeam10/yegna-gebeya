import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yegna_gebeya/shared/domain/models/image_type.dart';
import 'package:yegna_gebeya/shared/domain/models/user.dart';
import 'package:yegna_gebeya/shared/domain/repositories/image_repository.dart';
import 'package:yegna_gebeya/shared/domain/repositories/user_repository.dart';

part 'profile_info_update_state.dart';

class ProfileInfoUpdateCubit extends Cubit<ProfileInfoUpdateState> {
  UserRepository profileRepository;
  ImageRepository imageRepository;
  User currentUser;
  ProfileInfoUpdateCubit({
    required this.profileRepository,
    required this.imageRepository,
    required this.currentUser,
  }) : super(ProfileInfoUpdateInitial(user: currentUser));

  Future<void> updateProfile({
    File? image,
    required User oldUser,
    required User newUser,
  }) async {
    emit(ProfileInfoUpdateLoading(user: currentUser));

    try {
      if (image != null) {
        final uploadedImage = await imageRepository.uploadImage(
          image: image,
          imageType: newUser.role == UserRole.buyer
              ? ImageType.buyerProfile
              : ImageType.sellerProfile,
        );
        newUser = newUser.copyWith(imgUrl: uploadedImage);
      }
      await profileRepository.setCurrentUserInfo(
        curUser: oldUser,
        newUser: newUser,
      );
      emit(ProfileInfoUpdateSuccess(user: newUser));
    } catch (e) {
      emit(ProfileInfoUpdateFailure(user: currentUser));
    }
  }
}
