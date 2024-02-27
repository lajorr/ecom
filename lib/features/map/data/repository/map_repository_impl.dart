import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositity/map_repository.dart';
import '../data%20source/map_data_source.dart';

class MapRepositoryImpl implements MapRepository {
  final MapDataSource dataSource;

  MapRepositoryImpl({required this.dataSource});

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
