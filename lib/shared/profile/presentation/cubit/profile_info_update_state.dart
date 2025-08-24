part of 'profile_info_update_cubit.dart';

@immutable
sealed class ProfileInfoUpdateState {
  final User user;
  const ProfileInfoUpdateState({required this.user});
}

final class ProfileInfoUpdateInitial extends ProfileInfoUpdateState {
  const ProfileInfoUpdateInitial({required super.user});
}

final class ProfileInfoUpdateLoading extends ProfileInfoUpdateState {
  const ProfileInfoUpdateLoading({required super.user});
}

final class ProfileInfoUpdateSuccess extends ProfileInfoUpdateState {
  const ProfileInfoUpdateSuccess({required super.user});
}

final class ProfileInfoUpdateFailure extends ProfileInfoUpdateState {
  const ProfileInfoUpdateFailure({required super.user});
}
