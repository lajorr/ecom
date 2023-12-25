import '../data/data_source/product_data_source.dart';
import '../../../shared/product/model/product_global_model.dart';

// abstract class ProductRepository {
//   List<Product> getProductList();
// }

class ProductRepositoryImpl {
  final ProductDataSourceImpl productDataSource = ProductDataSourceImpl();

  // ProductRepositoryImpl({required this.productDataSource});
  // @override
  List<Product> getProductList() {
    final result = productDataSource.getProductList();
    return result;
  }
}


