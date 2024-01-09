import '../widgets/category_list.dart';
import '../widgets/search_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../blocs/catalog bloc/catalog_bloc.dart';
import '../widgets/header.dart';
import '../widgets/my_grid_view.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  static const routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CatalogBloc>(),
      child: const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 14.0,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),

                //header
                Header(),
                // search Box
                SearchBox(),
                //category
                CategoryList(),
                // grid
                Expanded(
                  child: MyGridView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
