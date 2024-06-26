import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/img_uri.dart';
import '../../../../shared/catalog/model/product_model.dart';
import '../../../prod_detail/presentation/screens/details_screen.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';

class MyGridTile extends StatelessWidget {
  const MyGridTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          final currentUser = state.currentUser;
          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(DetailsScreen.routeName, arguments: {
                'product': product,
                'currentUser': currentUser,
              });
            },
            child: Column(
              children: [
                //image
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: product.prodImage[0].imageUrl,
                    placeholder: (context, url) => Center(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Container(
                          height: media.height * 0.28,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Title
                    Text(
                      product.prodTitle,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    //vcategory
                    Text(
                      product.category.name,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[700],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //price
                        Text("\$${product.price.toString()}"),
                        Row(
                          children: [
                            Image.asset(
                              ImageConstants.getImageUri(
                                  ImageConstants.starIcon),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('${product.rating}'),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
