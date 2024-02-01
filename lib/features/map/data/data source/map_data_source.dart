import 'package:ecom/core/location-functions/map_location.dart';
import 'package:geolocator/geolocator.dart';

abstract class MapDataSource {
  Future<Position> getCurrentPosition();
  Future<Position> setMarkerPosition();
}

class MapDataSourceImpl implements MapDataSource {
  final MapLocation mapLocation;


  // static Pos

  MapDataSourceImpl({required this.mapLocation});
  @override
  Future<Position> getCurrentPosition() async {
    final pos = await mapLocation.determinePosition();
    print('pos');
    return pos;
  }

  @override
  Future<Position> setMarkerPosition() {
    // TODO: implement setMarkerPosition
    throw UnimplementedError();
  }
}
