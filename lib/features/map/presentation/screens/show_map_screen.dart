import 'dart:async';

import 'package:ecom/features/map/presentation/bloc/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMapScreen extends StatefulWidget {
  const ShowMapScreen({super.key});

  @override
  State<ShowMapScreen> createState() => _ShowMapScreenState();

  static const routeName = '/show-map-screen';
}

class _ShowMapScreenState extends State<ShowMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late Position position;

  @override
  void initState() {
    super.initState();

    context.read<MapBloc>().add(GetCurrentPositionEvent());
  }

  Set<Marker> markers0 = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        if (state is MapLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is MapLoaded) {
          final position = state.position;
          final latlong = LatLng(
            position.latitude,
            position.longitude,
          );

          

          final camPos = CameraPosition(
            target: latlong,
            zoom: 14.4746,
          );

          CameraPosition centerCam = CameraPosition(
            bearing: 192.8334901395799,
            target: latlong,
            tilt: 59.440717697143555,
            zoom: 19.151926040649414,
          );

          // final Set<Marker> markers = {};

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                await controller.animateCamera(
                  CameraUpdate.newCameraPosition(centerCam),
                );
              },
              child: const Icon(
                Icons.navigation,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            body: SafeArea(
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: camPos,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: markers0,
                onTap: (tappedPoint) {
                  setState(
                    () {
                      markers0.add(
                        Marker(
                          markerId: MarkerId(tappedPoint.toString()),
                          position: tappedPoint,
                          infoWindow: const InfoWindow(
                            title: 'Marker',
                            snippet: 'Tap to remove',
                          ),
                        ),
                      );
                      if (markers0.length > 1) {
                        markers0.remove(markers0.first);
                      }
                    },
                  );
                },
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text('ELSE'),
            ),
          );
        }
      },
    );
  }
}
