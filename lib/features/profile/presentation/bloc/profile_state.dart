part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  const ProfileLoaded({required this.email});
  final String email;
}

final class ProfileUserUnavailable extends ProfileState{}
