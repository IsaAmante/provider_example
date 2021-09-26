import 'package:exemplo_belo/src/controllers/controller.dart';
import 'package:exemplo_belo/src/models/product_model.dart';
import 'package:hive/hive.dart';

class WishlistController extends Controller {
  WishlistController() {
    //setStatus(Status.loading);
    // Hive.registerAdapter(ProductAdapter());
    _getLocalWishlist();
    //setStatus(Status.success);
  }

  _getLocalWishlist() async {
    // Box productsBox = await Hive.openBox('wishlist');
    // _wishlist = productsBox.getAt(0);
    // for (int i = 0; i < productsBox.length; i++)
    //   _wishlist.add(productsBox.get(i) as Product);
  }

  List<Product> _wishlist = [];

  List<Product> get wishlist => List.unmodifiable(_wishlist);

  createWishlist() {}

  bool isWishlisted(Product product) {
    return _wishlist.any((element) => element == product);
  }

  Future<bool> switchWishListed(Product product) async {
    bool wishlisted = isWishlisted(product);
    if (wishlisted) {
      _wishlist.remove(product);
      // await Hive.box('wishlist').deleteAt(0);
      // await Hive.box('wishlist').add(_wishlist);
    } else {
      _wishlist.add(product);
      // await Hive.box('wishlist').deleteAt(0);
      // await Hive.box('wishlist').add(_wishlist);
    }
    notifyListeners();
    return !wishlisted;
  }
}
