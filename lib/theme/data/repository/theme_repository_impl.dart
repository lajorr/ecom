import 'package:dartz/dartz.dart';
import '../../../core/error/exception.dart';
import '../../../core/error/failures.dart';
import '../data%20source/shared_pref_datasource.dart';

import '../../domain/repository/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final SharedPrefDataSource spDataSource;

  ThemeRepositoryImpl({required this.spDataSource});
  @override
  Future<Either<Failure, bool>> fetchThemeStatus() async {
    try {
      final status = await spDataSource.getThemeStatus();
      return Right(status);
    } on SharedPreferenceException {
      return const Left(
        SharedPrefFailure(message: "failed to fetch"),
      );
    }
  }

  @override
  Future<Either<Failure, void>> storeThemeStatus(bool isDark) async {
    try {
      final res = await spDataSource.storeData(isDark);
      return Right(res);
    } on SharedPreferenceException {
      return const Left(
        SharedPrefFailure(message: 'Couldnt store'),
      );
    }
  }
}
