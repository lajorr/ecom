// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  // events haru ma chai yo yetai rakhda vayo
  // kinavane events haru same ayeni matlab hudaina
  // tara states haru chai matter garxa
  // tesaile states ma chai individual class ma props pathaune
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  const LoginEvent({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  const SignUpEvent({required this.email, required this.password});
}

class CheckUserExistsEvent extends AuthEvent {}

class GoogleSignInEvent extends AuthEvent {}
