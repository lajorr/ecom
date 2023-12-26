import '../../../../product_json_data/product_json.dart';
import '../../../../shared/catalog/model/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getProductList();
}

class ProductDataSourceImpl implements ProductDataSource {
  @override
  Future<List<ProductModel>> getProductList() async {
    List<ProductModel> productList = [];
    for (var prod in ProductData.products) {
      var product = ProductModel.fromJson(prod);
      productList.add(product);
    }

    return productList;
  }
}
