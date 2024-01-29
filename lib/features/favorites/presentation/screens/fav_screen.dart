import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../catalog/presentation/widgets/my_grid_tile.dart';
import '../bloc/favorites_bloc.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FavoritesBloc>().add(FetchFavProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FAV"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FavoritesLoaded) {
            final favProds = state.prodList;

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}







// final favProds = prodP.getFavProd();

//                 if (favProds.isEmpty) {
//                   return const Center(
//                     child: Text(
//                       StringConstants.noFavText,
//                     ),
//                   );
//                 }
//                 return Expanded(
//                   child: MasonryGridView.builder(
//                     gridDelegate:
//                         const SliverSimpleGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
//                     ),
//                     itemCount: favProds.length,
//                     itemBuilder: (context, index) {
//                       final prod = favProds[index];

//                       return MyGridTile(
//                         product: prod,
//                       );
//                     },
//                   ),