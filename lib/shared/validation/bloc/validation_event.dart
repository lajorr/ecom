part of 'validation_bloc.dart';

sealed class ValidationEvent extends Equatable {
  const ValidationEvent();

  @override
  List<Object> get props => [];
}

class ValidateInputEvent extends ValidationEvent {
  final String email;
  final String password;

  const ValidateInputEvent({required this.email, required this.password});
}
