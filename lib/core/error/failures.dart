import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class FirebaseFailure extends Failure {}

class InvalidInputFailure extends Failure {}

class EmptyFieldFailure extends Failure{}

class NoUserFailure extends Failure{}