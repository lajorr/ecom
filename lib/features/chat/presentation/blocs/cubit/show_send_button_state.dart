part of 'show_send_button_cubit.dart';

sealed class ShowSendButtonState extends Equatable {
  const ShowSendButtonState();

  @override
  List<Object> get props => [];
}

final class ShowSendButtonTrue extends ShowSendButtonState {}

final class ShowSendButtonFalse extends ShowSendButtonState {}
