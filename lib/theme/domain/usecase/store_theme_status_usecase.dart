import 'package:dartz/dartz.dart';
import '../../../core/error/failures.dart';
import '../../../core/usecase/usecase.dart';
import '../repository/theme_repository.dart';

class StoreThemeStatusUsecase extends Usecase<void, bool> {
  StoreThemeStatusUsecase({required this.repository});
  final ThemeRepository repository;
  @override
  Future<Either<Failure, void>> call(bool params) async {
    return await repository.storeThemeStatus(params);
  }
}
