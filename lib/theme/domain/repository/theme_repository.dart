import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';

abstract class ThemeRepository {
  Future<Either<Failure, bool>> fetchThemeStatus();
  Future<Either<Failure, void>> storeThemeStatus(bool isDark);
}
