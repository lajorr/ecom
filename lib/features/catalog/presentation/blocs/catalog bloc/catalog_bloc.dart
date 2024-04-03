import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ecom/core/usecase/usecase.dart';
import 'package:ecom/features/catalog/domain/usecase/get_product_data_usecase.dart';
import 'package:ecom/shared/catalog/enitity/enum/category_enum.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';
import 'package:equatable/equatable.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {

  CatalogBloc({
    required this.getProductDataUsecase,
  }) : super(CatalogInitial()) {
    on<FetchProductDataEvent>(_onFetchProductDataEvent);
    on<FilterProductsEvent>(_onFilterProducts);
    on<SearchProductsEvent>(_onSearchProducts);
  }
  List<ProductModel> _allProductsList = [];

  final GetProductDataUsecase getProductDataUsecase;

  FutureOr<void> _onFetchProductDataEvent(
      FetchProductDataEvent event, Emitter<CatalogState> emit,) async {
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
      FilterProductsEvent event, Emitter<CatalogState> emit,) {
    emit(CatalogLoading());
    final cat = event.category;
    var filteredList = <ProductModel>[];
    if (cat == Category.all) {
      filteredList = _allProductsList;
    } else {
      filteredList =
          _allProductsList.where((prodM) => prodM.category == cat).toList();
    }

    emit(CatalogLoaded(productList: filteredList));
  }

  FutureOr<void> _onSearchProducts(
      SearchProductsEvent event, Emitter<CatalogState> emit,) {
    emit(CatalogLoading());
    var filteredList = <ProductModel>[];

    final query = event.query.toLowerCase();

    filteredList = _allProductsList
        .where(
          (prodM) => prodM.prodTitle.toLowerCase().contains(query),
        )
        .toList();
    emit(CatalogLoaded(productList: filteredList));
  }
}
