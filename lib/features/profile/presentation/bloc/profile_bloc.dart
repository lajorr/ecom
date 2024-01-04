// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/profile/domain/usecase/udpate_user_data_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecase/fetch_user_data_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required this.fetchUserDataUsecase,
    required this.updateUserDataUsecase,
  }) : super(ProfileInitial()) {
    on<FetchUserDataEvent>(_onFetchUserData);
    on<UpdateUserDataEvent>(_onUpdateUserData);
  }

  final FetchUserDataUsecase fetchUserDataUsecase;
  final UpdateUserDataUsecase updateUserDataUsecase;

  FutureOr<void> _onUpdateUserData(
      UpdateUserDataEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final userOrFail = await updateUserDataUsecase.call(
      UserParams(
        username: event.username!,
        phNumber: int.parse(event.phNumber ?? "000"),
      ),
    );

    userOrFail.fold(
        (failure) => emit(
              ProfileUserUpdateFailed(),
            ), (user) {
      emit(ProfileUserUpdateSuccess());
      emit(
        ProfileLoaded(
          email: user.email ?? "",
          phNumber: user.phNumber,
          username: user.name,
        ),
      );
    });
  }

  FutureOr<void> _onFetchUserData(
      FetchUserDataEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    final userOrFail = await fetchUserDataUsecase.call(NoParams());

    userOrFail.fold(
        (failure) => emit(
              ProfileUserUnavailable(),
            ), (user) {
      emit(
        ProfileLoaded(
          email: user.email!,
          phNumber: user.phNumber,
          username: user.name,
        ),
      );
    });
  }
}
