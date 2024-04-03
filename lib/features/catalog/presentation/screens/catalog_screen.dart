import 'package:ecom/features/catalog/presentation/blocs/catalog%20bloc/catalog_bloc.dart';
import 'package:ecom/features/catalog/presentation/widgets/catalog_shimmer.dart';
import 'package:ecom/features/catalog/presentation/widgets/category_list.dart';
import 'package:ecom/features/catalog/presentation/widgets/header.dart';
import 'package:ecom/features/catalog/presentation/widgets/my_grid_view.dart';
import 'package:ecom/features/catalog/presentation/widgets/search_box.dart';
import 'package:ecom/features/checkout/presentation/blocs/checkoutbloc/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              horizontal: 14,
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
                      return CatalogShimmer(
                        media: media,
                      );
                    } else if (state is CatalogLoaded) {
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
                    } else if (state is CatalogFailure) {
                      return const Text('Something went wrong');
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),),
      ),
    );
  }
}
