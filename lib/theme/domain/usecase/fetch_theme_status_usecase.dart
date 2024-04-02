import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/theme/domain/repository/theme_repository.dart';

class FetchThemeStatusUsecase extends Usecase<bool, NoParams> {
  FetchThemeStatusUsecase({required this.repository});
  final ThemeRepository repository;
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.fetchThemeStatus();
  }
}
