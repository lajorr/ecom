// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/map/domain/usecase/get_current_user_position_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc({
    required this.getCurrentUserPositionUsecase,
  }) : super(MapInitial()) {
    on<GetCurrentPositionEvent>(_onGetCurrentPosition);
  }

  final GetCurrentUserPositionUsecase getCurrentUserPositionUsecase;

  FutureOr<void> _onGetCurrentPosition(
      GetCurrentPositionEvent event, Emitter<MapState> emit) async {
    emit(MapLoading());
    print("BLOCC");
    final posOrFail = await getCurrentUserPositionUsecase.call(NoParams());
    posOrFail.fold((l) {
      emit(MapFailed());
    }, (pos) {
      print("SUCCESS");
      emit(MapLoaded(position: pos));
    });
  }
}
