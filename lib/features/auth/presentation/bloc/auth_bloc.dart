// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/auth/domain/usecases/login_with_email_usecase.dart';
import 'package:ecom/features/auth/domain/usecases/signin_with_google_usecase.dart';
import 'package:ecom/features/auth/domain/usecases/signup_with_email_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../../../../constants/string_constants.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    // required this.textValidator,
    required this.loginUsecase,
    required this.signupUsecase,
    required this.googleSigninUsecase,
  }) : super(AuthInitial()) {
    // on<InputValidationEvent>(_onInputValidate);
    on<LoginEvent>(_onLogin);
    on<SignUpEvent>(_onSignUp);
    on<GoogleSignInEvent>(_onGoogleSignIn);
  }

  // final TextValidator textValidator;
  final LoginWithEmailUsecase loginUsecase;
  final SignupWithEmailUsecase signupUsecase;
  final SigninWithGoogleUsecase googleSigninUsecase;

  // FutureOr<void> _onInputValidate(
  //     InputValidationEvent event, Emitter<AuthState> emit) {
  //   final eitherValid = textValidator.inputChecker(event.email, event.password);

  //   eitherValid.fold(
  //       (failure) => emit(
  //             const InvalidCreds(message: StringConstants.invalidInputText),
  //           ),
  //       (valid) => emit(CredsValidated()));
  // }

  FutureOr<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
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

  FutureOr<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    final signUpOrFail = await signupUsecase.call(
      Params(
        email: event.email,
        password: event.password,
      ),
    );
    if (signUpOrFail.isLeft()) {
      signUpOrFail.leftMap((failure) {
        emit(const AuthFailure(message: StringConstants.invalidCredsText));
      });
    } else {
      signUpOrFail.map((user) => emit(AuthSuccess(user: user)));
    }
  }

  FutureOr<void> _onGoogleSignIn(
      GoogleSignInEvent event, Emitter<AuthState> emit) async {
    debugPrint('google sign in');
    final userOrFail = await googleSigninUsecase.call(NoParams());
    userOrFail.fold(
        (failure) => emit(const AuthFailure(message: 'Something Went Wro=ng')),
        (user) {
      emit(AuthLoading());
      emit(AuthSuccess(user: user));
    });
  }
}