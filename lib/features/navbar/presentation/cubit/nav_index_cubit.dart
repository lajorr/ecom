import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'nav_index_state.dart';

class NavIndexCubit extends Cubit<NavIndexState> {
  NavIndexCubit() : super(const NavIndexCurrent(index: 0));

  Future<void> onChangeNavIndex(int index) async {
    emit(NavIndexChanged(index: index));
  }

  Future<void> onSetCurrentIndex(int index) async {
    emit(NavIndexCurrent(index: index));
  }
}
