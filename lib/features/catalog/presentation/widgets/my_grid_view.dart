import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

import '../blocs/catalog bloc/catalog_bloc.dart';
import 'my_grid_tile.dart';

class MyGridView extends StatefulWidget {
  const MyGridView({
    Key? key,
  }) : super(key: key);

  @override
  State<MyGridView> createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<CatalogBloc>(context).add(FetchProductDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: BlocBuilder<CatalogBloc, CatalogState>(
        builder: (context, state) {
          if (state is CatalogLoading) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              child: GridViewShimmer(media: media),
            );
          } else if (state is CatalogLoaded) {
            final productList = state.productList;
            if (productList.isEmpty) {
              return const Center(
                child: Text('No Such Products'),
              );
            }
            return MasonryGridView.count(
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
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class GridViewShimmer extends StatelessWidget {
  const GridViewShimmer({
    super.key,
    required this.media,
  });

  final Size media;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 10,
      itemCount: 4,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: media.height * 0.28,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            SizedBox(
              height: media.height * 0.01,
            ),
            Container(
              height: media.height * 0.025,
              width: media.width * 0.25,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              height: media.height * 0.01,
            ),
            Container(
              height: media.height * 0.015,
              width: media.width * 0.125,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              height: media.height * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: media.height * 0.025,
                  width: media.width * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  height: media.height * 0.025,
                  width: media.width * 0.125,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
