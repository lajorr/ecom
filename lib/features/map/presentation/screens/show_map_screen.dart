// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:ecom/features/map/presentation/bloc/map_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMapScreen extends StatefulWidget {
  const ShowMapScreen({
    required this.onConfirmPosition, super.key,
  });

  @override
  State<ShowMapScreen> createState() => _ShowMapScreenState();

  static const routeName = '/show-map-screen';

  final Function(LatLng) onConfirmPosition;
}

class _ShowMapScreenState extends State<ShowMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    context.read<MapBloc>().add(GetCurrentPositionEvent());
  }

  Set<Marker> markers = {};

  LatLng? latLng;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        if (state is MapFailed) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: Center(
              child: Text(state.message),
            ),
          );
        } else if (state is MapLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is MapLoaded) {
          final position = state.position;
          final currentUserLatlng = LatLng(
            position.latitude,
            position.longitude,
          );

          final camPos = CameraPosition(
            target: currentUserLatlng,
            zoom: 14.4746,
          );

          final centerCam = CameraPosition(
            bearing: 192.8334901395799,
            target: currentUserLatlng,
            tilt: 59.440717697143555,
            zoom: 19.151926040649414,
          );

          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                final controller = await _controller.future;
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
              child: Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: camPos,
                    onMapCreated: _controller.complete,
                    markers: markers,
                    onTap: (tappedPoint) {
                      setState(
                        () {
                          latLng = tappedPoint;
                          markers = {
                            Marker(
                              markerId: MarkerId(tappedPoint.toString()),
                              position: tappedPoint,
                            ),
                          };
                        },
                      );
                    },
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: IconButton(
                        onPressed: () {
                          if (latLng == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please select a location..'),
                                duration: Duration(milliseconds: 1000),
                              ),
                            );
                            return;
                          } else {
                            Navigator.of(context).pop();
                            widget.onConfirmPosition(latLng!);
                          }
                        },
                        icon: const Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
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
