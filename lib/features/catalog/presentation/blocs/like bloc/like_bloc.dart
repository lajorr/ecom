// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/features/catalog/domain/usecase/fetch_like_doc_usecase.dart';
import 'package:ecom/features/catalog/domain/usecase/like_unlike_prod_usecase.dart';
import 'package:equatable/equatable.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  LikeBloc({
    
    required this.fetchLikeDocUsecase,
    required this.likeUnlikeProdUsecase,
  }) : super(LikeLoading()) {
    on<LikeButtonPressedEvent>(_onLikeButtonPressed);
    on<FetchLikeDocumentEvent>(_onFetchLikeDocuments);
  }

  
  final FetchLikeDocUsecase fetchLikeDocUsecase;
  final LikeUnlikeProdUsecase likeUnlikeProdUsecase;

  FutureOr<void> _onFetchLikeDocuments(
      FetchLikeDocumentEvent event, Emitter<LikeState> emit,) async {
    emit(LikeLoading());
    final likeOrFail = await fetchLikeDocUsecase.call(event.prodId);

    likeOrFail.fold((failure) => emit(LikeFailed()), (likeModel) {
      emit(LikeSuccess(isLiked: likeModel.isLiked));
    });
  }

  FutureOr<void> _onLikeButtonPressed(
      LikeButtonPressedEvent event, Emitter<LikeState> emit,) async {
    final likeOrFail = await likeUnlikeProdUsecase.call(event.prodId);

    likeOrFail.fold((failure) => emit(LikeFailed()), (isLiked) {
      emit(LikeSuccess(isLiked: isLiked));
    });
  }
}
