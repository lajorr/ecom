part of 'map_bloc.dart';

sealed class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

final class MapInitial extends MapState {}

final class MapLoaded extends MapState {
  const MapLoaded({required this.position});
  final Position position;
}

final class MapLoading extends MapState {}

final class MapFailed extends MapState {
  const MapFailed({required this.message});
  final String message;
}
