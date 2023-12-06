import 'package:ecom/screens/details_screen.dart';
import 'package:ecom/services/product_provider.dart';
import 'package:ecom/widgets/my_grid_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class MyGridView extends StatelessWidget {
  const MyGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final prodP = Provider.of<ProductProvider>(context);

    final productList = prodP.productList;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 4,
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];

          return MyGridTile(
            product: product,
          );
        },
      ),
    );
  }
}
