// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/auth/domain/usecases/check_user_usecase.dart';
import 'package:ecom/features/auth/domain/usecases/login_with_email_usecase.dart';
import 'package:ecom/features/auth/domain/usecases/set_user_data_usecase.dart';
import 'package:ecom/features/auth/domain/usecases/sign_out_usecase.dart';
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
    required this.loginUsecase,
    required this.signupUsecase,
    required this.googleSigninUsecase,
    required this.checkUserUsercase,
    required this.signOutUsecase,
    required this.setUserDataUsecase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignUpEvent>(_onSignUp);
    on<GoogleSignInEvent>(_onGoogleSignIn);
    on<CheckUserExistsEvent>(_onCheckUserExists);
    on<SignOutEvent>(_onSignOut);
  }

  final LoginWithEmailUsecase loginUsecase;
  final SignupWithEmailUsecase signupUsecase;
  final SigninWithGoogleUsecase googleSigninUsecase;
  final CheckUserUsercase checkUserUsercase;
  final SignOutUsecase signOutUsecase;
  final SetUserDataUsecase setUserDataUsecase;

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
        emit(const AuthFailed(message: StringConstants.invalidCredsText));
        emit(UserUnavailable());
      });
    } else {
      loginOrFail.map((user) {
        emit(AuthSuccess(user: user));
        emit(const UserAvailable());
      });
    }
  }

  FutureOr<void> _onCheckUserExists(
      CheckUserExistsEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final userOrFail = await checkUserUsercase.call(NoParams());

    if (userOrFail.isLeft()) {
      emit(UserUnavailable());
    } else {
      debugPrint('availabe');
      emit(const UserAvailable());
    }
  }
Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
  emit(AuthLoading());
  final signUpOrFail = await signupUsecase.call(
    Params(
      email: event.email,
      password: event.password,
    ),
  );

  if (signUpOrFail.isLeft()) {
    
    emit(const AuthFailed(message: StringConstants.invalidCredsText));
    emit(UserUnavailable());
  } else {
      
    final userResult = signUpOrFail.getOrElse(() => throw UnimplementedError());

    if (userResult != null) {
      emit(AuthSuccess(user: userResult));
      emit(UserAvailable(email: userResult.email));
      final userStoredOrFail = await setUserDataUsecase.call(userResult);

      userStoredOrFail.fold(
        (failure) {
          
          emit(AuthSetUserFailed());
        },
        (response) {
          
          emit(AuthSetUserSuccess());
        },
      );
    } else {
      
      // Handle the case where userResult is not a User or is null
      emit(const AuthFailed(message: "User data unavailable"));
      emit(UserUnavailable());
    }
  }
}

  // FutureOr<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
  //   emit(AuthLoading());
  //   final signUpOrFail = await signupUsecase.call(
  //     Params(
  //       email: event.email,
  //       password: event.password,
  //     ),
  //   );

  //   if (signUpOrFail.isLeft()) {
  //     emit(const AuthFailed(message: StringConstants.invalidCredsText));
  //     emit(UserUnavailable());
  //   } else {
  //     signUpOrFail.map((user) async {
  //       emit(AuthSuccess(user: user));
  //       emit(UserAvailable(email: user.email));
  //       final userStoredOrFail = await setUserDataUsecase.call(user);
  //       userStoredOrFail.fold(
  //         (failure) {
  //           print("failedddd");
  //           emit(
  //             AuthSetUserFailed(),
  //           );
  //         },
  //         (response) {
  //           print("Successsss");

  //           emit(AuthSetUserSuccess());
  //         },
  //       );
  //     });
  //   }
  // }



  FutureOr<void> _onGoogleSignIn(
      GoogleSignInEvent event, Emitter<AuthState> emit) async {
    debugPrint('google sign in');
    final userOrFail = await googleSigninUsecase.call(NoParams());
    userOrFail.fold(
        (failure) => emit(const AuthFailed(message: 'Something Went Wro=ng')),
        (user) {
      emit(AuthLoading());
      emit(AuthSuccess(user: user!));
    });
  }

  FutureOr<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    final signOurOrFail = await signOutUsecase.call(NoParams());

    signOurOrFail.fold(
        (failure) => emit(
              SignoutFailed(),
            ), (response) {
      emit(AuthLoading());
      emit(SignoutSuccess());
    });
  }
}
