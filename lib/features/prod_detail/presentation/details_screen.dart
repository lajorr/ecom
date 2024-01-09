// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/common/widgets/like_button.dart';
import 'package:ecom/common/widgets/my_button.dart';
import 'package:ecom/common/widgets/rounded_button.dart';
import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/features/prod_detail/presentation/prod_info.dart';
import 'package:ecom/features/prod_detail/presentation/product_size.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../catalog/presentation/blocs/like bloc/like_bloc.dart';
import 'show_cart_button.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductModel product;

  static const routeName = '/prod-detail';

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<LikeBloc>(context).add(
      FetchLikeDocumentEvent(prodId: widget.product.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocBuilder<LikeBloc, LikeState>(
            builder: (context, state) {
              if (state is LikeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LikeSuccess) {
                return Column(
                  children: [
                    //image
                    Stack(
                      children: [
                        SizedBox(
                          height: media.height * 0.5,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.product.prodImage.length,
                            itemBuilder: (context, index) {
                              final image = widget.product.prodImage[index];

                              return SizedBox(
                                width: media.width - 40,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: CachedNetworkImage(
                                    imageUrl: image.imageUrl,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const MyButton(
                                size: 50,
                                dropShadow: true,
                              ),
                              LikeButton(
                                prodId: widget.product.id,
                                isFav: state.isLiked,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    //title row
                    ProdInfo(product: widget.product),

                    Divider(
                      height: media.height * 0.07,
                    ),

                    // size
                    ProductSize(product: widget.product),

                    // add to cart button

                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 15,
                        ),
                        child: const Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: RoundedButton(
                                text: StringConstants.addToCartText,
                                iconUri: ImageConstants.shopCart,
                              ),
                            ),
                            ShowCartButton(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
