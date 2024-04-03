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

  const ValidationFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [];
}
