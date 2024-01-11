// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/common/widgets/like_button.dart';
import 'package:ecom/common/widgets/my_button.dart';
import 'package:ecom/common/widgets/rounded_button.dart';
import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:ecom/features/prod_detail/presentation/widgets/product_size.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../catalog/presentation/blocs/like bloc/like_bloc.dart';
import '../../../checkout/domain/model/cart_product_model.dart';
import '../widgets/show_cart_button.dart';

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
  int quantity = 1;

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
                return page(
                  media: media,
                  state: state,
                  context: context,
                );
              } else {
                return page(
                  media: media,
                  context: context,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Column page({
    required Size media,
    LikeSuccess? state,
    required BuildContext context,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    isFav: state?.isLiked ?? false,
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

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 200,
              child: Text(
                widget.product.prodTitle,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    // color: Colors.red,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.remove,
                    ),
                    onPressed: () {
                      setState(() {
                        if (quantity > 1) {
                          quantity -= 1;
                        }
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    quantity.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(
                      25,
                    ),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                    ),
                    onPressed: () {
                      setState(() {
                        quantity += 1;
                      });
                    },
                  ),
                ),
              ],
            )
          ],
        ),
        // rating
        Row(
          children: [
            SizedBox(
              // width: 200,
              width: media.width * 0.35,
              height: media.height * 0.03,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.product.rating.round(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Image.asset(
                    ImageConstants.getImageUri(ImageConstants.starIcon),
                  );
                },
              ),
            ),
            RichText(
              text: TextSpan(
                text: '${widget.product.rating} ',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "(${widget.product.viewsNo})",
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: media.height * 0.01,
        ),
        // details
        Text(
          widget.product.prodDescription,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),

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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Builder(builder: (context) {
                    return RoundedButton(
                      onTap: () {
                        context.read<CheckoutBloc>().add(
                              AddToCartEvent(
                                cartProduct: CartProductModel(
                                  product: widget.product,
                                  quantity: quantity,
                                ),
                              ),
                            );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('ADDED!!'),
                            backgroundColor: Colors.green,
                            duration: Duration(milliseconds: 500),
                          ),
                        );
                      },
                      text: StringConstants.addToCartText,
                      iconUri: ImageConstants.shopCart,
                    );
                  }),
                ),
                const ShowCartButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
