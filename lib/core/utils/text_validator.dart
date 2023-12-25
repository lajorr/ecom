import 'package:dartz/dartz.dart';
import '../extensions/string_validator.dart';

import '../error/failures.dart';

class TextValidator {
  Either<Failure, bool> inputChecker(String email, String password) {
    if (email.isEmpty || password.isEmpty) {
      return Left(EmptyFieldFailure());
    }

    if (email.isValidEmail() || password.isValidPassword()) {
      return const Right(true);
    }
    else
    {
      return Left(InvalidInputFailure());
    }
  }
}
