import 'package:ecom/core/location-functions/map_location.dart';
import 'package:geolocator/geolocator.dart';

abstract class MapDataSource {
  Future<Position> getCurrentPosition();
}

class MapDataSourceImpl implements MapDataSource {
  final MapLocation mapLocation;

  MapDataSourceImpl({required this.mapLocation});
  @override
  Future<Position> getCurrentPosition() async {
    final pos = await mapLocation.determinePosition();
    print('pos');
    return pos;
  }
}
