import 'package:ecom/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
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
    context.read<ProfileBloc>().add(FetchUserDataEvent());
    context.read<CheckoutBloc>().add(FetchCartProductsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CatalogBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
            ),
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoaded) {
                  // final a = state.currentUser.uid ==
                  final user = state.currentUser;
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      //header
                      const Header(),
                      // search Box
                      const SearchBox(),
                      //category
                      const CategoryList(),
                      // grid
                      Expanded(
                        child: MyGridView(currentUser: user),
                      ),
                    ],
                  );
                } else if (state is ProfileLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
