import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/shared/catalog/enitity/enum/category_enum.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/usecase/usecase.dart';
import '../../../../../shared/catalog/model/product_model.dart';
import '../../../domain/usecase/get_product_data_usecase.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  List<ProductModel> _allProductsList = [];

  CatalogBloc({
    required this.getProductDataUsecase,
  }) : super(CatalogInitial()) {
    on<FetchProductDataEvent>(_onFetchProductDataEvent);
    on<FilterProductsEvent>(_onFilterProducts);
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
      _allProductsList = productList;
      emit(CatalogLoaded(productList: _allProductsList));
    });
  }

  FutureOr<void> _onFilterProducts(
      FilterProductsEvent event, Emitter<CatalogState> emit) {
    emit(CatalogLoading());
    final cat = event.category;
    List<ProductModel> filteredList = [];
    if (cat == Category.all) {
      filteredList = _allProductsList;
    } else {
      filteredList =
          _allProductsList.where((prodM) => prodM.category == cat).toList();
    }

    emit(CatalogLoaded(productList: filteredList));
  }
}
