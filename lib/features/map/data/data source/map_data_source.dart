import 'package:ecom/core/location-functions/map_location.dart';
import 'package:geolocator/geolocator.dart';

abstract class MapDataSource {
  Future<Position> getCurrentPosition();
}

class MapDataSourceImpl implements MapDataSource {

  MapDataSourceImpl({required this.mapLocation});
  final MapLocation mapLocation;
  @override
  Future<Position> getCurrentPosition() async {
    final pos = await mapLocation.determinePosition();
    return pos;
  }
}
