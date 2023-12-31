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
    required this.username,
    required this.phNumber,
    required this.email,
  });
  final String email;
  final String? username;
  final int? phNumber;
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
