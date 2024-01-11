import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/catalog/domain/usecase/get_product_data_usecase.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';
import 'package:equatable/equatable.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc({
    required this.getProductDataUsecase,
  }) : super(CatalogInitial()) {
    on<FetchProductDataEvent>(_onFetchProductDataEvent);
  }

  final GetProductDataUsecase getProductDataUsecase;

  FutureOr<void> _onFetchProductDataEvent(
      FetchProductDataEvent event, Emitter<CatalogState> emit) async {
    emit(CatalogLoading());
    final dataOrFail = await getProductDataUsecase.call(NoParams());

    dataOrFail.fold(
        (failure) => emit(
              CatalogFailure(),
            ), (productList) {
      emit(CatalogLoaded(productList: productList));
    });
  }
}
