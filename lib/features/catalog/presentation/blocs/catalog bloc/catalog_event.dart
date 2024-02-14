part of 'catalog_bloc.dart';

sealed class CatalogEvent extends Equatable {
  const CatalogEvent();

  @override
  List<Object> get props => [];
}

class FetchProductDataEvent extends CatalogEvent {}

class FilterProductsEvent extends CatalogEvent {
  const FilterProductsEvent({
    required this.category,
  });
  final Category category;
}
