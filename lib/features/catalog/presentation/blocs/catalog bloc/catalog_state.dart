part of 'catalog_bloc.dart';

sealed class CatalogState extends Equatable {
  const CatalogState();
}

final class CatalogInitial extends CatalogState {
  @override
  List<Object> get props => [];
}

final class CatalogLoading extends CatalogState {
  @override
  List<Object> get props => [];
}

final class CatalogLoaded extends CatalogState {
  final List<ProductModel> productList;

  const CatalogLoaded({required this.productList});

  @override
  List<Object> get props => [];
}

final class CatalogFailure extends CatalogState {
  @override
  List<Object> get props => [];
}

final class CatalogDocumentExists extends CatalogState {
  @override
  List<Object> get props => [];
}

final class CatalogDocumentNoExist extends CatalogState {
  @override
  List<Object> get props => [];
}
