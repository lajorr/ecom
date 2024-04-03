import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/exception.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/theme/data/data%20source/shared_pref_datasource.dart';

import 'package:ecom/theme/domain/repository/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {

  ThemeRepositoryImpl({required this.spDataSource});
  final SharedPrefDataSource spDataSource;
  @override
  Future<Either<Failure, bool>> fetchThemeStatus() async {
    try {
      final status = await spDataSource.getThemeStatus();
      return Right(status);
    } on SharedPreferenceException {
      return const Left(
        SharedPrefFailure(message: 'failed to fetch'),
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
