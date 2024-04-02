import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../repository/theme_repository.dart';

class FetchThemeStatusUsecase extends Usecase<bool, NoParams> {
  FetchThemeStatusUsecase({required this.repository});
  final ThemeRepository repository;
  @override
  Future<Either<Failure, bool>> call(params) async {
    return await repository.fetchThemeStatus();
  }
}
