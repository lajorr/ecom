import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';

abstract class ThemeRepository {
  Future<Either<Failure, bool>> fetchThemeStatus();
  Future<Either<Failure, void>> storeThemeStatus(bool isDark);
}
