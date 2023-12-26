import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/img_uri.dart';
import '../../../../constants/string_constants.dart';
import '../../../../injection_container.dart';
import '../bloc/catalog_bloc.dart';
import '../widgets/category_tile.dart';
import '../widgets/header.dart';
import '../widgets/my_grid_view.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  static const routeName = '/home-screen';

  @override
  Widget build(BuildContext context) {
    final outlinedBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 215, 215, 215),
      ),
      borderRadius: BorderRadius.circular(15),
    );

    return BlocProvider(
      create: (context) => sl<CatalogBloc>(),
      child: Scaffold(
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
                // search Box
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),
                            prefixIcon: Image.asset(
                              ImageConstants.getImageUri(
                                  ImageConstants.searchIcon),
                            ),
                            // prefix:
                            hintText: StringConstants.searchHintText,

                            // hintStyle: ,
                            enabledBorder: outlinedBorder,
                            focusedBorder: outlinedBorder,
                            border: outlinedBorder,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      //filter
                      Container(
                        height: 50,
                        width: 50,
                        // color: Colors.red,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          ImageConstants.getImageUri(
                            ImageConstants.filterIcon,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //category
                Container(
                  height: 50,
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      CategoryTile(
                        iconUri: ImageConstants.allCategory,
                        title: StringConstants.allItemsText,
                      ),
                      CategoryTile(
                        iconUri: ImageConstants.dressIcon,
                        title: StringConstants.dressText,
                        isActive: true,
                      ),
                      CategoryTile(
                        iconUri: ImageConstants.hatIcon,
                        title: StringConstants.hatText,
                      ),
                      CategoryTile(
                        iconUri: ImageConstants.watchIcon,
                        title: StringConstants.watchText,
                      ),
                    ],
                  ),
                ),

                // grid

                const Expanded(
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
