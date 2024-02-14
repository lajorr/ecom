// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../blocs/catalog bloc/catalog_bloc.dart';
import 'my_grid_tile.dart';

class MyGridView extends StatefulWidget {
  const MyGridView({
    Key? key,
    required this.currentUser,
  }) : super(key: key);

  final UserModel currentUser;

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
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        if (state is CatalogLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CatalogLoaded) {
          final productList = state.productList;
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
        } else {
          return Container();
        }
      },
    );
  }
}
