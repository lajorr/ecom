import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/exception.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:ecom/features/map/data/data%20source/map_data_source.dart';
import 'package:ecom/features/map/domain/repositity/map_repository.dart';
import 'package:geolocator/geolocator.dart';

class MapRepositoryImpl implements MapRepository {

  MapRepositoryImpl({required this.dataSource});
  final MapDataSource dataSource;

  @override
  Future<Either<Failure, Position>> getCurrentUserPosition() async {
    try {
      final pos = await dataSource.getCurrentPosition();
      return Right(pos);
    } on LocationException {
      return const Left(
        LocationFailure(message: 'No Gps Service found.. Please turn it on.'),
      );
    }
  }
}
