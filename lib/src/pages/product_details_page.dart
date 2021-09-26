import 'package:cached_network_image/cached_network_image.dart';
import 'package:exemplo_belo/src/consts/palette.dart';
import 'package:exemplo_belo/src/controllers/wishlist.dart';
import 'package:exemplo_belo/src/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Palette.primaryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back, size: 35),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.1,
                left: 30,
                right: 30,
              ),
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.63,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: Palette.text,
                      fontWeight: FontWeight.w200,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'R\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Palette.primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(height: 30),
                  Expanded(
                    child: Scrollbar(
                      isAlwaysShown: false,
                      child: SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            product.description,
                            style: TextStyle(
                              color: Palette.text,
                              fontWeight: FontWeight.w300,
                              fontSize: 14,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: Consumer<WishlistController>(
                        builder: (context, controller, _) {
                      return ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: Palette.secondaryColor,
                          textStyle: TextStyle(
                            color: Palette.headerElements,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onPressed: () {
                          controller.switchWishListed(product);
                          WidgetsBinding.instance!.addPostFrameCallback((_) {
                            print('Quando');
                          });
                        },
                        icon: Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.symmetric(vertical: 6),
                          padding: EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            color: Palette.headerElements,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              controller.isWishlisted(product)
                                  ? Icons.favorite_rounded
                                  : Icons.favorite_border_rounded,
                              color: Palette.secondaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                        label: controller.isWishlisted(product)
                            ? Text('Já adicionado à Wishlist')
                            : Text('Adicionar à Wishlist'),
                      );
                    }),
                  ),
                  // Center(
                  //   child: Container(
                  //     width: 50,
                  //     height: 50,
                  //     padding: EdgeInsets.only(top: 4),
                  //     decoration: BoxDecoration(
                  //       color: Palette.secondaryColor,
                  //       borderRadius: BorderRadius.all(
                  //         Radius.circular(50),
                  //       ),
                  //     ),
                  //     child: Center(
                  //       child: Icon(
                  //         Icons.favorite_rounded,
                  //         color: Colors.white,
                  //         size: 30,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 30, top: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  boxShadow: [
                    BoxShadow(
                      color: Palette.text.withOpacity(0.1),
                      offset: Offset(0, 3),
                      spreadRadius: 0.3,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(30),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.height * 0.3,
                    child: Stack(
                      children: [
                        Hero(
                          tag: product.id,
                          child: Center(
                            child: CachedNetworkImage(
                              fit: BoxFit.scaleDown,
                              placeholder: (_, __) => CircularProgressIndicator(
                                color: Palette.secondaryColor,
                              ),
                              imageUrl: product.imgUrl,
                            ),
                          ),
                        ),
                        Consumer<WishlistController>(
                            builder: (context, controller, _) {
                          if (controller.isWishlisted(product))
                            return Center(
                              child: Icon(
                                Icons.favorite_rounded,
                                color: Palette.secondaryColor.withOpacity(0.5),
                                size: 50,
                              ),
                            );
                          return Container();
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
