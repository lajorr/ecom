import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'show_send_button_state.dart';

class ShowSendButtonCubit extends Cubit<ShowSendButtonState> {
  ShowSendButtonCubit() : super(ShowSendButtonFalse());

  Future<void> toggleSendVisibility(String value) async {
    if (value.isEmpty || value == '') {
      emit(ShowSendButtonFalse());
    } else {
      emit(ShowSendButtonTrue());
    }
  }
}
