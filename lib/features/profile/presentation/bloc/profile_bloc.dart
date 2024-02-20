import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/profile/domain/usecase/update_user_data_usecase.dart';
import 'package:ecom/features/profile/domain/usecase/upload_profile_picture_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecase/fetch_user_data_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required this.fetchUserDataUsecase,
    required this.updateUserDataUsecase,
    required this.uploadProfilePictureUsecase,
  }) : super(ProfileLoading()) {
    on<FetchUserDataEvent>(_onFetchUserData);
    on<UpdateUserDataEvent>(_onUpdateUserData);
    on<UploadProfilePictureEvent>(_onUploadProfilePicture);
  }

  final FetchUserDataUsecase fetchUserDataUsecase;
  final UpdateUserDataUsecase updateUserDataUsecase;
  final UploadProfilePictureUsecase uploadProfilePictureUsecase;

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
        ProfileLoaded(currentUser: user),
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
        ProfileLoaded(currentUser: user),
      );
    });
  }

  FutureOr<void> _onUploadProfilePicture(
      UploadProfilePictureEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());

    final uploadOrFail = await uploadProfilePictureUsecase.call(event.image);

    uploadOrFail.fold((failure) => emit(ProfilePictureUploadFailed()), (user) {
      emit(
        ProfileLoaded(
            // imageUrl: user.imageUrl,
            // username: user.name,
            // phNumber: user.phNumber,
            // email: user.email!,
            currentUser: user),
      );
    });
  }
}
