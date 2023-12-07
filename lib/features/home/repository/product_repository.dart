import 'package:ecom/features/home/data/data_souce/product_data_source.dart';
import 'package:ecom/shared/product/model/product_global_model.dart';

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


