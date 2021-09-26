import 'package:exemplo_belo/src/consts/palette.dart';
import 'package:exemplo_belo/src/controllers/wishlist.dart';
import 'package:exemplo_belo/src/models/product_model.dart';
import 'package:exemplo_belo/src/pages/widgets/products_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  _WishlistPageState();
  bool showBanner = false;
  late int _index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        (widget.products.length > 0)
            ? GridView.count(
                padding: const EdgeInsets.all(8),
                crossAxisCount: 2,
                children: List.generate(
                  widget.products.length,
                  (index) => ProductCardWidget(
                    product: widget.products[index],
                    showFavoriteIcon: true,
                    showShareIcon: true,
                    wishlisted: true,
                    onTap: (Product product) {
                      // Provider.of<WishlistController>(context, listen: false)
                      //     .switchWishListed(product);
                      _showBanner(index);
                    },
                  ),
                ),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border_rounded,
                        color: Palette.text.withOpacity(0.3),
                        size: 130,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Você ainda não possui nenhum item na Wishlist.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Palette.text,
                          fontSize: 19,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        if (showBanner)
          Container(
            height: 125,
            child: MaterialBanner(
              padding: EdgeInsets.all(20),
              content: Text(
                  '${widget.products[_index].name} será removido da sua Wishlist. Deseja continuar?'),
              contentTextStyle: TextStyle(
                color: Palette.textHeader,
              ),
              backgroundColor: Palette.highlight,
              actions: <Widget>[
                TextButton(
                  child: Text(
                    'CANCELAR',
                    style: TextStyle(
                      color: Palette.headerElements,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      showBanner = false;
                    });
                    // Provider.of<WishlistController>(context, listen: false)
                    //     .switchWishListed(products[_index]);
                  },
                ),
                TextButton(
                  child: Text(
                    'REMOVER',
                    style: TextStyle(
                      color: Palette.headerElements,
                    ),
                  ),
                  onPressed: () {
                    showBanner = false;
                    Provider.of<WishlistController>(context, listen: false)
                        .switchWishListed(widget.products[_index]);

                    Fluttertoast.cancel();
                    Fluttertoast.showToast(
                      msg: 'Removido da Wishlist',
                      backgroundColor: Palette.highlight,
                    );
                  },
                ),
              ],
            ),
          ),
      ],
    );
  }

  _showBanner(int index) {
    setState(() {
      _index = index;
      showBanner = true;
    });
  }
}
