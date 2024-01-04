part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  const ProfileLoaded({
    required this.username,
    required this.phNumber,
    required this.email,
  });
  final String email;
  final String? username;
  final int? phNumber;
}

final class ProfileUserUnavailable extends ProfileState {}

final class ProfileUserUpdateSuccess extends ProfileState {}

final class ProfileUserUpdateFailed extends ProfileState {}
