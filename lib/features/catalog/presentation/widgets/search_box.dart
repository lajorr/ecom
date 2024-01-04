import 'package:flutter/material.dart';

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
    );
  }
}
