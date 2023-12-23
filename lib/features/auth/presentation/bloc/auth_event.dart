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

class LoginWithEmailEvent extends AuthEvent {
  const LoginWithEmailEvent({required this.email, required this.password});

  final String email;
  final String password;
}



class InputValidationEvent extends AuthEvent {
  final String email;
  final String password;

  const InputValidationEvent({required this.email, required this.password});
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginEvent({
    required this.email,
    required this.password,
  });
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  const SignUpEvent({required this.email, required this.password});
}
