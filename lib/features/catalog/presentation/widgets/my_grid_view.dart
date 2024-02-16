// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecom/shared/catalog/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../constants/img_uri.dart';
import '../blocs/catalog bloc/catalog_bloc.dart';
import 'my_grid_tile.dart';

class MyGridView extends StatefulWidget {
  const MyGridView({
    Key? key,
    required this.productList,
  }) : super(key: key);

  final List<ProductModel> productList;

  @override
  State<MyGridView> createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final productList = widget.productList;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: (productList.isEmpty)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  ImageConstants.getImageUri(
                    ImageConstants.notAvailableIcon,
                  ),
                ),
                SizedBox(
                  height: media.height * 0.03,
                ),
                const Text(
                  'Not Available',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            )
          : MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
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
