import '../../../../core/firebaseFunctions/firebase_collections.dart';
import '../../../../shared/catalog/model/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getAllProductList();

  // List<ProductModel> getFilteredList(Category category);
}

class ProductDataSourceImpl implements ProductDataSource {
  final FireCollections fireCollection;

  // List<ProductModel> _allProductsList = [];

  ProductDataSourceImpl({required this.fireCollection});
  @override
  Future<List<ProductModel>> getAllProductList() async {
    return await fireCollection.getAllProductsFromCollection();
  }

  // @override
  // List<ProductModel> getFilteredList(Category category) {
  //   List<ProductModel> filteredList = [];
  //   filteredList =
  //       _allProductsList.where((prodM) => prodM.category == category).toList();
  //   print(_allProductsList);
  //   return filteredList;
  // }
}
