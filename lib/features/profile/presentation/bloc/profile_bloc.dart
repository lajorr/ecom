// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecase/fetch_user_data_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(
    {required this.fetchUserDataUsecase,}
  ) : super(ProfileInitial()) {
    on<FetchUserDataEvent>(_onFetchUserData);
  }

  final FetchUserDataUsecase fetchUserDataUsecase;

  FutureOr<void> _onFetchUserData(
      FetchUserDataEvent event, Emitter<ProfileState> emit) async {
    final userOrFail = await fetchUserDataUsecase.call(NoParams());

    userOrFail.fold(
        (failure) => emit(
              ProfileUserUnavailable(),
            ), (user) {
      emit(
        ProfileLoaded(email: user.email!),
      );
    });
  }
}
