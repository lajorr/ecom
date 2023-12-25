// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/core/utils/text_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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
    debugPrint("validate input event");

    final eitherValid = textValidator.inputChecker(event.email, event.password);
    eitherValid.fold(
      (failure) {
        emit(
          const ValidationFailure(message: 'Validation failed'),
        );
        // emit(InvalidCreds(message: 'asd'))
      },
      (isValid) => emit(
        ValidationSuccess(),
      ),
    );
  }
}
