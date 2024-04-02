import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/img_uri.dart';
import '../../../../constants/string_constants.dart';
import '../blocs/catalog%20bloc/catalog_bloc.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
    required this.media,
  }) : super(key: key);

  final Size media;

  @override
  Widget build(BuildContext context) {
    final outlinedBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).primaryColor,
      ),
      borderRadius: BorderRadius.circular(15),
    );

    return Container(
      height: media.height * 0.1,
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
                hintText: StringConstants.searchHintText.tr(),

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
            height: media.height * 0.1,
            width: media.height * 0.07,
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
