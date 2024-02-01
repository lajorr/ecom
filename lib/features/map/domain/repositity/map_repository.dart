import 'package:dartz/dartz.dart';
import 'package:ecom/core/error/failures.dart';
import 'package:geolocator/geolocator.dart';

abstract class MapRepository {
  Future<Either<Failure, Position>> getCurrentUserPosition();
  Future<Either<Failure, Position>> addDeliveryLocation();
}
