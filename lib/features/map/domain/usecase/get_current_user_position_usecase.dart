import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositity/map_repository.dart';

class GetCurrentUserPositionUsecase extends Usecase<Position, NoParams> {
  final MapRepository repository;

  GetCurrentUserPositionUsecase({required this.repository});

  @override
  Future<Either<Failure, Position>> call(NoParams params) async {
    return await repository.getCurrentUserPosition();
  }
}
