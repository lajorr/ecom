// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/features/favorites/domain/usecase/fetch_fav_products_usecase.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc({
    required this.fetchFavProductsUsecase,
  }) : super(FavoritesInitial()) {
    on<FetchFavProductsEvent>(_onFetchFavPRoducts);
  }

  final FetchFavProductsUsecase fetchFavProductsUsecase;

  FutureOr<void> _onFetchFavPRoducts(
      FetchFavProductsEvent event, Emitter<FavoritesState> emit) async {
    emit(FavoritesLoading());
    final fetchOrFail = await fetchFavProductsUsecase.call(NoParams());

    fetchOrFail.fold((failure) => emit(FavoritesFailed()), (prodList) {
      emit(FavoritesLoaded(prodList: prodList));
    });
  }
}
