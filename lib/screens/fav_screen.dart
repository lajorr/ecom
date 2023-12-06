import 'package:ecom/services/product_provider.dart';
import 'package:ecom/widgets/custom_appbar.dart';
import 'package:ecom/widgets/my_grid_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              //
              const CustomAppbar(
                title: 'Favorites',
                backButton: false,
                actions: false,
              ),
              const SizedBox(
                height: 10,
              ),

              Consumer<ProductProvider>(builder: (context, prodP, _) {
                final favProds = prodP.getFavProd();

                if (favProds.isEmpty) {
                  return const Center(
                    child: Text('No Fav'),
                  );
                }
                return Expanded(
                  child: MasonryGridView.builder(
                    gridDelegate:
                        const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: favProds.length,
                    itemBuilder: (context, index) {
                      final prod = favProds[index];

                      return MyGridTile(
                        product: prod,
                      );
                    },
                  ),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
