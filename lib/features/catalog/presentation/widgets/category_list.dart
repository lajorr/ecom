import 'package:ecom/features/catalog/presentation/blocs/catalog%20bloc/catalog_bloc.dart';
import 'package:ecom/shared/catalog/enitity/enum/category_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/img_uri.dart';
import '../../../../constants/string_constants.dart';
import 'category_tile.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  List<Map<String, dynamic>> filterCatList = [
    {
      'icon': ImageConstants.allCategory,
      'title': StringConstants.allItemsText,
      'category': Category.all,
    },
    {
      'icon': ImageConstants.dressIcon,
      'title': StringConstants.dressText,
      'category': Category.dress,
    },
    {
      'icon': ImageConstants.techIcon,
      'title': StringConstants.techText,
      'category': Category.tech,
    },
    {
      'icon': ImageConstants.watchIcon,
      'title': StringConstants.watchText,
      'category': Category.watch,
    },
  ];

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Container(
      height: media.height * 0.075,
      margin: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filterCatList.length,
        itemBuilder: (context, index) {
          final cat = filterCatList[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              context.read<CatalogBloc>().add(
                    FilterProductsEvent(
                      category: cat['category'],
                    ),
                  );
            },
            child: CategoryTile(
              iconUri: cat['icon'],
              title: cat['title'],
              isActive: selectedIndex == index,
            ),
          );
        },
      ),
    );
  }
}
