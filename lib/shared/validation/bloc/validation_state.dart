part of 'validation_bloc.dart';

sealed class ValidationState extends Equatable {
  const ValidationState();
}

final class ValidationInitial extends ValidationState {
  @override
  List<Object> get props => [];
}

final class ValidationSuccess extends ValidationState {
  @override
  List<Object> get props => [];
}

final class ValidationFailure extends ValidationState {
  final String message;

  const ValidationFailure({required this.message});
  @override
  List<Object> get props => [];
}
