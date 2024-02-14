import 'package:flutter/material.dart';

import '../../../../constants/img_uri.dart';
import '../../../../constants/string_constants.dart';
import 'category_tile.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            title: StringConstants.techText,
          ),
          CategoryTile(
            iconUri: ImageConstants.watchIcon,
            title: StringConstants.watchText,
          ),
        ],
      ),
    );
  }
}
