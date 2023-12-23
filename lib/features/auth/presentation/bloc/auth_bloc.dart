// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/core/utils/text_validator.dart';
import 'package:ecom/features/auth/domain/usecases/login_with_email_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../constants/string_constants.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final TextValidator textValidator;

  final LoginWithEmailUsecase loginUsecase;
  AuthBloc({
    required this.textValidator,
    required this.loginUsecase,
  }) : super(AuthInitial()) {
    on<InputValidationEvent>(_onInputValidate);
    on<LoginEvent>(_onLogin);
  }

  FutureOr<void> _onInputValidate(
      InputValidationEvent event, Emitter<AuthState> emit) {
    final eitherValid = textValidator.inputChecker(event.email, event.password);
    if (eitherValid.isLeft()) {
      emit(
        const InvalidCreds(message: StringConstants.invalidInputText),
      );
    } else {
      emit(CredsValidated());
    }
  }

  FutureOr<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    final eitherValid = textValidator.inputChecker(event.email, event.password);
    if (eitherValid.isLeft()) {
      emit(
        const InvalidCreds(message: StringConstants.invalidInputText),
      );
    } else {
      emit(AuthLoading());

      final loginOrFail = await loginUsecase.call(
        Params(
          email: event.email,
          password: event.password,
        ),
      );

      if (loginOrFail.isLeft()) {
        loginOrFail.leftMap((failure) {
          emit(const AuthFailure(message: StringConstants.invalidCredsText));
        });
      } else {
        loginOrFail.map((user) => emit(AuthSuccess(user: user)));
      }
    }
  }
}
