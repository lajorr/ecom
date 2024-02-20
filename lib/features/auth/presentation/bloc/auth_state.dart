part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final UserModel? user;

  const AuthSuccess({required this.user});
}

final class AuthFailed extends AuthState {
  final String message;

  const AuthFailed({required this.message});
}

final class InvalidCreds extends AuthState {
  final String message;

  const InvalidCreds({required this.message});
}

final class UserAvailable extends AuthState {
  const UserAvailable({
    required this.user,
  });

  final UserModel? user;
}

final class UserUnavailable extends AuthState {}

final class SignoutSuccess extends AuthState {}

final class SignoutFailed extends AuthState {}
