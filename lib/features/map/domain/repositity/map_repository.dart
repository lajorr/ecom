import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/error/failures.dart';

abstract class MapRepository {
  Future<Either<Failure, Position>> getCurrentUserPosition();
}
