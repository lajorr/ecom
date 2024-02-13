part of 'nav_index_cubit.dart';

sealed class NavIndexState extends Equatable {
  const NavIndexState();

  @override
  List<Object> get props => [];
}

final class NavIndexInitial extends NavIndexState {}

final class NavIndexChanged extends NavIndexState {
  const NavIndexChanged({required this.index});
  final int index;
}

final class NavIndexCurrent extends NavIndexState {
  const NavIndexCurrent({required this.index});
  final int index;
}
