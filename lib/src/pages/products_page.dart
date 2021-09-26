import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:exemplo_belo/src/consts/palette.dart';
import 'package:exemplo_belo/src/controllers/auth.dart';
import 'package:exemplo_belo/src/controllers/products.dart';
import 'package:exemplo_belo/src/controllers/wishlist.dart';
import 'package:exemplo_belo/src/models/product_model.dart';
import 'package:exemplo_belo/src/pages/widgets/app_bar.dart';
import 'package:exemplo_belo/src/pages/widgets/products_list_widget.dart';
import 'package:exemplo_belo/src/pages/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  _ProducsPageState createState() => _ProducsPageState();
}

class _ProducsPageState extends State<ProductsPage>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scafKey = GlobalKey();
  GlobalKey<CurvedNavigationBarState> _barState = GlobalKey();

  // Itens relacionados à animação
  late AnimationController _animationController = AnimationController(
    vsync: this,
    lowerBound: 0.75,
    upperBound: 1,
    duration: Duration(seconds: 2),
  )..repeat(reverse: true);

  late final Animation<double> _sizeAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOut,
  );

  Color _iconColor = Colors.greenAccent.withOpacity(0.1);
  late Future<List<Product>> getProduct;

  late PageController _pageController;

  Map<int, String> _titles = {
    0: 'Produtos',
    1: 'Wishlist',
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    getProduct = context.read<ProductsController>().fetchProducts();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getProduct = context.read<ProductsController>().fetchProducts();
  }

  @override
  void didUpdateWidget(covariant ProductsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    getProduct = context.read<ProductsController>().fetchProducts();
  }

  @override
  void dispose() {
    // Os controller de animação devem ser disposed.
    // No caso do Provider (ProductsController), não é
    // necessário dar dispose, pois o MultiProvider lá
    // no main lida com isso :)
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          key: _scafKey,
          appBar: BeloAppBar(
            title: _titles[_pageController.positions.isNotEmpty
                ? _pageController.page?.round() ?? 0
                : 0]!,
            showDrawer: true,
            leadingAction: () {
              _scafKey.currentState?.openDrawer();
            },
          ),
          drawer: SafeArea(
            child: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Palette.primaryColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                height: 50,
                                fit: BoxFit.scaleDown,
                                placeholder: (context, url) => Center(
                                  child: Container(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Palette.headerElements,
                                      backgroundColor: Palette.primaryColor,
                                    ),
                                  ),
                                ),
                                errorWidget: (_, __, ___) => Container(),
                                imageUrl: Provider.of<AuthController>(context,
                                            listen: false)
                                        .user
                                        ?.photoUrl ??
                                    '',
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                'Bem-vinde,\n${Provider.of<AuthController>(context, listen: false).user?.displayName ?? ""}!',
                                style: TextStyle(
                                  color: Palette.textHeader,
                                  fontSize: 19,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            Provider.of<AuthController>(context, listen: false)
                                .signOut();
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.logout_rounded,
                                color: Palette.headerElements,
                              ),
                              Text(
                                'Sair',
                                style: TextStyle(
                                  color: Palette.headerElements,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: FutureBuilder(
            future: getProduct,
            builder: (context, AsyncSnapshot<List<Product>> snapshot) {
              return (snapshot.hasData)
                  ? PageView(
                      controller: _pageController,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (index) {
                        setState(() {
                          _barState.currentState?.setPage(index);
                        });
                      },
                      children: [
                        Consumer<ProductsController>(
                            builder: (context, controller, _) =>
                                ProductsListWidget(
                                    products: controller.products)),
                        Consumer<WishlistController>(
                            builder: (context, controller, _) =>
                                WishlistPage(products: controller.wishlist)),
                      ],
                    ) //ChangeTextWidget(iconColor: _iconColor)
                  : Center(
                      child: CircularProgressIndicator(
                        color: Palette.secondaryColor,
                      ),
                    );
            },
          ),
          floatingActionButton: GestureDetector(
            onTap: () {
              // Aqui usei um setState só para mostrar como ele funciona,
              // mas também seria possível colocar o Icon dentro
              // de um Consumer, já que usamos o secretChangeText() logo depois
              setState(() {
                _iconColor = Colors.redAccent;
              });
              // Provider.of<ProductsController>(context, listen: false)
              //     .secretChangeText();
            },
            // Só uma gracinha com um coração s2
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: AnimatedBuilder(
                animation: _sizeAnimation,
                builder: (context, child) => Transform.scale(
                  scale: _animationController.value,
                  child: child,
                ),
                child: Icon(
                  Icons.favorite_border_rounded,
                  color: _iconColor,
                  size: 50,
                ),
              ),
            ),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            key: _barState,
            color: Palette.primaryColor,
            backgroundColor: Palette.headerElements,
            buttonBackgroundColor: Palette.primaryColor,
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 300),
            height: 50,
            onTap: (index) {
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut);
              setState(() {});
            },
            items: [
              Icon(
                Icons.shopping_cart_outlined,
                color: Palette.headerElements,
              ),
              Icon(
                Icons.favorite_border_rounded,
                color: Palette.headerElements,
              ),
            ],
          ),

          /* Bottom NavigationBar(
                backgroundColor: Palette.primaryColor,
                selectedItemColor: Palette.textHeader,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: 'Produtos',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite_border_rounded),
                    label: 'Wishlist',
                  ),
                ],
              ), */
        ),
      ),
    );
  }
}
