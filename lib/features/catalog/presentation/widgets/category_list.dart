import 'package:flutter/material.dart';

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
    },
    {
      'icon': ImageConstants.dressIcon,
      'title': StringConstants.dressText,
    },
    {
      'icon': ImageConstants.techIcon,
      'title': StringConstants.techText,
    },
    {
      'icon': ImageConstants.watchIcon,
      'title': StringConstants.watchText,
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
