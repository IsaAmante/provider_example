import 'package:cached_network_image/cached_network_image.dart';
import 'package:exemplo_belo/src/consts/palette.dart';
import 'package:exemplo_belo/src/models/product_model.dart';
import 'package:exemplo_belo/src/pages/product_details_page.dart';
import 'package:flutter/material.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    Key? key,
    required this.product,
    this.showFavoriteIcon = false,
    this.showShareIcon = false,
    this.wishlisted = false,
    this.onTap,
  }) : super(key: key);

  final Product product;
  final bool wishlisted, showFavoriteIcon, showShareIcon;
  final Function(Product product)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              product: product,
            ),
          ),
        );
      },
      child: Card(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 4),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: GestureDetector(
                      onDoubleTap: () {
                        if (onTap != null) onTap!(product);
                      },
                      child: Hero(
                        tag: product.id,
                        child: CachedNetworkImage(
                          placeholder: (_, __) => CircularProgressIndicator(
                            color: Palette.secondaryColor,
                          ),
                          imageUrl: product.imgUrl,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Divider(
                    color: Palette.text,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Palette.secondaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'R\$${product.price.toStringAsFixed(2)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Palette.primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  if (showFavoriteIcon)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, right: 8),
                      child: GestureDetector(
                        onTap: () {
                          if (onTap != null) onTap!(product);
                        },
                        child: Icon(
                          wishlisted
                              ? Icons.favorite
                              : Icons.favorite_border_rounded,
                          color: Palette.secondaryColor,
                        ),
                      ),
                    ),
                  if (showShareIcon)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, right: 8),
                      child: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.share_rounded,
                          size: 20,
                          color: Palette.text,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
