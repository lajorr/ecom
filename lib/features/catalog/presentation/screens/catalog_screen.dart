import 'package:ecom/features/catalog/presentation/widgets/catalog_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../checkout/presentation/blocs/checkoutbloc/checkout_bloc.dart';
import '../blocs/catalog bloc/catalog_bloc.dart';
import '../widgets/category_list.dart';
import '../widgets/header.dart';
import '../widgets/my_grid_view.dart';
import '../widgets/search_box.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  static const routeName = '/home-screen';

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CheckoutBloc>().add(FetchCartProductsEvent());
    BlocProvider.of<CatalogBloc>(context).add(FetchProductDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),

                //header
                const Header(),
                BlocBuilder<CatalogBloc, CatalogState>(
                  builder: (context, state) {
                    if (state is CatalogLoading) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: CatalogShimmer(
                          media: media,
                        ),
                      );
                    }
                     else if (state is CatalogLoaded) {
                      final productList = state.productList;
                      return Expanded(
                        child: Column(
                          children: [
                            // search Box
                            SearchBox(
                              media: media,
                            ),
                            //category
                            CategoryList(
                              media: media,
                            ),
                            // grid
                            Expanded(
                              child: MyGridView(productList: productList),
                            ),
                          ],
                        ),
                      );
                    } 
                    else if (state is CatalogFailure) {
                      return const Text('Something went wrong');
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            )),
      ),
    );
  }
}
