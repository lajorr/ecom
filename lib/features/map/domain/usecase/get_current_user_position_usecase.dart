import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/map/domain/repositity/map_repository.dart';
import 'package:geolocator/geolocator.dart';

class GetCurrentUserPositionUsecase extends Usecase<Position, NoParams> {

  GetCurrentUserPositionUsecase({required this.repository});
  final MapRepository repository;

  @override
  Future<Either<Failure, Position>> call(NoParams params) async {
    return await repository.getCurrentUserPosition();
  }
}
