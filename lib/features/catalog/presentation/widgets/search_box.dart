import 'package:ecom/features/catalog/presentation/blocs/catalog%20bloc/catalog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/img_uri.dart';
import '../../../../constants/string_constants.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    final outlinedBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 215, 215, 215),
      ),
      borderRadius: BorderRadius.circular(15),
    );

    return Padding(
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
                  ImageConstants.getImageUri(ImageConstants.searchIcon),
                ),
                // prefix:
                hintText: StringConstants.searchHintText,

                enabledBorder: outlinedBorder,
                focusedBorder: outlinedBorder,
                border: outlinedBorder,
              ),
              onChanged: (value) {
                context
                    .read<CatalogBloc>()
                    .add(SearchProductsEvent(query: value));
              },
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          //filter
          Container(
            height: 50,
            width: 50,
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
    );
  }
}
