import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/core/utils/text_validator.dart';
import 'package:equatable/equatable.dart';

part 'validation_event.dart';
part 'validation_state.dart';

class ValidationBloc extends Bloc<ValidationEvent, ValidationState> {
  ValidationBloc({
    required this.textValidator,
  }) : super(ValidationInitial()) {
    on<ValidateInputEvent>(_onValidateEvent);
  }

  final TextValidator textValidator;

  FutureOr<void> _onValidateEvent(
      ValidateInputEvent event, Emitter<ValidationState> emit) {
    emit(ValidationInitial());

    final eitherValid = textValidator.inputChecker(event.email, event.password);
    eitherValid.fold((failure) {
      emit(
        ValidationFailure(message: failure.message),
      );
    }, (isValid) {
      emit(
        ValidationSuccess(),
      );
    });
  }
}
