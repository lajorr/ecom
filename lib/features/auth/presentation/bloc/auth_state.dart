part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final User user;

  const AuthSuccess({required this.user});
}

final class AuthFailure extends AuthState {
  final String message;

  const AuthFailure({required this.message});
}

final class InvalidCreds extends AuthState {
  final String message;

  const InvalidCreds({required this.message});
}
final class CredsValidated extends AuthState{}
