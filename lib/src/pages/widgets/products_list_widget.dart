import 'package:exemplo_belo/src/consts/palette.dart';
import 'package:exemplo_belo/src/controllers/products.dart';
import 'package:exemplo_belo/src/controllers/wishlist.dart';
import 'package:exemplo_belo/src/models/product_model.dart';
import 'package:exemplo_belo/src/pages/widgets/products_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class ProductsListWidget extends StatefulWidget {
  const ProductsListWidget({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  _ProductsListWidgetState createState() => _ProductsListWidgetState();
}

class _ProductsListWidgetState extends State<ProductsListWidget> {
  TextEditingController _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: _SliverAppBarDelegate(
            minHeight: 0,
            maxHeight: 53.0,
            child: Container(
              color: Colors.white70,
              child: TextField(
                controller: _inputController,
                onChanged: (text) {
                  Provider.of<ProductsController>(context, listen: false)
                      .filterProducts(text);
                },
                textAlignVertical: TextAlignVertical.center,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Busque aqui o seu produto',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search_rounded, color: Colors.grey),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _inputController.text = '';
                      Provider.of<ProductsController>(context, listen: false)
                          .filterProducts('');
                    },
                    child: Icon(Icons.cancel, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ),
        ),
        (widget.products.length > 0)
            ? SliverGrid.count(
                crossAxisCount: 2,
                children: List.generate(
                  widget.products.length,
                  (index) => Consumer<WishlistController>(
                    builder: (_, controller, __) => ProductCardWidget(
                      product: widget.products[index],
                      showFavoriteIcon: true,
                      wishlisted:
                          controller.isWishlisted(widget.products[index]),
                      onTap: (Product product) async {
                        bool result =
                            await controller.switchWishListed(product);

                        Fluttertoast.cancel();
                        Fluttertoast.showToast(
                          msg: result
                              ? 'Incluído na Wishlist'
                              : 'Removido da Wishlist',
                          backgroundColor: Palette.highlight,
                        );
                      },
                    ),
                  ),
                ),
              )
            : SliverFillRemaining(
                child: Text('Não foram encontrados dados para a sua busca.'),
              ),
      ],
    );

    /* 

    return GridView.count(
      padding: const EdgeInsets.all(8),
      crossAxisCount: 2,
      children: List.generate(
        widget.products.length,
        (index) => Consumer<WishlistController>(
          builder: (_, controller, __) => ProductCardWidget(
            product: widget.products[index],
            showFavoriteIcon: true,
            wishlisted: controller.isWishlisted(widget.products[index]),
            onTap: (Product product) async {
              bool result = await controller.switchWishListed(product);

              Fluttertoast.cancel();
              Fluttertoast.showToast(
                msg: result ? 'Incluído na Wishlist' : 'Removido da Wishlist',
                backgroundColor: Palette.highlight,
              );
            },
          ),
        ),
      ),
    ); */
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;
  @override
  double get minExtent => minHeight;
  @override
  double get maxExtent => math.max(maxHeight, minHeight);
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
