part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchUserDataEvent extends ProfileEvent {}

class UpdateUserDataEvent extends ProfileEvent {
  const UpdateUserDataEvent({
    required this.username,
    required this.phNumber,
  });

  final String? username;
  final String? phNumber;
}

class UploadProfilePictureEvent extends ProfileEvent {
  const UploadProfilePictureEvent({required this.image});
  final Uint8List image;
}
