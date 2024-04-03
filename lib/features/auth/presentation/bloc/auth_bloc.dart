import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/auth/domain/usecases/check_user_usecase.dart';
import 'package:ecom/features/auth/domain/usecases/login_with_email_usecase.dart';
import 'package:ecom/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:ecom/features/auth/domain/usecases/signup_with_email_usecase.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.loginUsecase,
    required this.signupUsecase,
    required this.checkUserUsercase,
    required this.signOutUsecase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignUpEvent>(_onSignUp);

    on<CheckUserExistsEvent>(_onCheckUserExists);
    on<SignOutEvent>(_onSignOut);
  }

  final LoginWithEmailUsecase loginUsecase;
  final SignupWithEmailUsecase signupUsecase;

  final CheckUserUsercase checkUserUsercase;
  final SignOutUsecase signOutUsecase;
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
        emit(
          AuthFailed(message: failure.message),
        );
        emit(UserUnavailable());
      });
    } else {
      loginOrFail.map((user) {
        emit(
          UserAvailable(user: user),
        );
      });
    }
  }

  FutureOr<void> _onCheckUserExists(
      CheckUserExistsEvent event, Emitter<AuthState> emit,) async {
    emit(AuthLoading());
    final userOrFail = await checkUserUsercase.call(NoParams());

    userOrFail.fold((failure) {
      emit(UserUnavailable());
    }, (user) {
      emit(
        UserAvailable(user: user),
      );
    });
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final signUpOrFail = await signupUsecase.call(
      Params(
        email: event.email,
        password: event.password,
      ),
    );

    signUpOrFail.fold(
      (failure) {
        emit(AuthFailed(message: failure.message));
      },
      (user) {
        if (user != null) {
          emit(
            UserAvailable(user: user),
          );
        } else {
          emit(UserUnavailable());
        }
      },
    );
  }

  FutureOr<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    final signOurOrFail = await signOutUsecase.call(NoParams());

    signOurOrFail.fold((failure) {
      emit(
        SignoutFailed(),
      );
    }, (response) {
      emit(AuthLoading());
      emit(SignoutSuccess());
    });
  }
}
