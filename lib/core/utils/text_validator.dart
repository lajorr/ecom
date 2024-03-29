
import 'package:dartz/dartz.dart';

import '../error/failures.dart';
import '../extensions/string_validator.dart';

class TextValidator {
  Either<Failure, bool> inputChecker(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      return const Left(EmptyFieldFailure(message: "Fields are empty"));
    }

    if (email.isValidEmail() || password.isValidPassword()) {
      return const Right(true);
    }
    else
    {
      return const Left(InvalidInputFailure(message: "Invalid Input"));
    }
  }
}
