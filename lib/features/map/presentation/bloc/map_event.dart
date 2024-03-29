part of 'map_bloc.dart';

sealed class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentPositionEvent extends MapEvent {}
class AddMarkerEvent extends MapEvent {}
