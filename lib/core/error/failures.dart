import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});
  @override
  List<Object?> get props => [message];
}

class FirebaseFailure extends Failure {
  const FirebaseFailure({super.message = "Firebase Failure"});
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure({required super.message});
}

class EmptyFieldFailure extends Failure {
  const EmptyFieldFailure({required super.message});
}

class NoUserFailure extends Failure {
  const NoUserFailure({required super.message});
}

class UserUpdateFailure extends Failure {
  const UserUpdateFailure({required super.message});
}

// catalog

class ServerFailure extends Failure {
  const ServerFailure({required super.message});
}

class DocumentFailure extends Failure {
  const DocumentFailure({required super.message});
}

class CartFailure extends Failure {
  const CartFailure({super.message = "Something went wrong with the cart"});
}

class EmptyCartFailure extends Failure {
  const EmptyCartFailure({required super.message});
}

class LocationFailure extends Failure {
  const LocationFailure({required super.message});
}

class SharedPrefFailure extends Failure {
  const SharedPrefFailure({required super.message});
}
