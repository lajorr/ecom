part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfileLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfileLoaded extends ProfileState {
  @override
  List<Object> get props => [];
  const ProfileLoaded({
    required this.currentUser,
    
  });
  
  final UserModel currentUser;
}

final class ProfileUserUnavailable extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfileUserUpdateSuccess extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfileUserUpdateFailed extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfilePictureUploadSuccess extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfilePictureUploadFailed extends ProfileState {
  @override
  List<Object> get props => [];
}

final class ProfilePictureUploadLoading extends ProfileState {
  @override
  List<Object> get props => [];
}
