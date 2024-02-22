import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ecom/common/widgets/like_button.dart';
import 'package:ecom/common/widgets/my_button.dart';
import 'package:ecom/common/widgets/rounded_button.dart';
import 'package:ecom/constants/img_uri.dart';
import 'package:ecom/constants/string_constants.dart';
import 'package:ecom/features/auth/data/model/user_model.dart';
import 'package:ecom/features/checkout/presentation/blocs/checkoutbloc/checkout_bloc.dart';
import 'package:ecom/features/prod_detail/presentation/widgets/chat_widget.dart';
import 'package:ecom/features/prod_detail/presentation/widgets/product_size.dart';
import 'package:ecom/shared/catalog/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../checkout/domain/model/cart_product_model.dart';
import '../widgets/show_cart_button.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.product,
    required this.currentUser,
  }) : super(key: key);

  final ProductModel product;
  final UserModel currentUser;

  static const routeName = '/prod-detail';

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int quantity = 1;
  late bool isOwner;

  @override
  void initState() {
    super.initState();

    isOwner = widget.currentUser == widget.product.owner;
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    String userText = ' ...';
    final owner = widget.product.owner;

    if (owner != null) {
      userText = widget.product.owner!.name!;
      if (isOwner) {
        userText = '$userText (YOU)';
      }
    }

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SizedBox(
          height: media.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //image
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                          // appbar
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
                          //prod name
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
                          // increment / decrement quantity
                          if (!isOwner)
                            Row(
                              children: [
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    quantity.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium,
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

                      //product owner
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '@$userText',
                                style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300),
                              ),
                              // rating
                              Row(
                                children: [
                                  SizedBox(
                                    width: media.width * 0.35,
                                    height: media.height * 0.03,
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: widget.product.rating.round(),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Image.asset(
                                          ImageConstants.getImageUri(
                                              ImageConstants.starIcon),
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
                            ],
                          ),
                          if (!isOwner)
                            ChatWidget(
                              otherUser: owner,
                              currentUserId: widget.currentUser.uid!,
                            ),
                        ],
                      ),

                      Divider(
                        height: media.height * 0.05,
                      ),

                      // size
                      ProductSize(product: widget.product),
                    ],
                  ),

                  // add to cart button
                  if (!isOwner)
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 15,
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
                                text: StringConstants.addToCartText.tr(),
                                iconUri: ImageConstants.shopCart,
                              );
                            }),
                          ),
                          const ShowCartButton(),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
