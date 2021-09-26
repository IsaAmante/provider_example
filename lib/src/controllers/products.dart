import 'package:exemplo_belo/src/controllers/controller.dart';
import 'package:exemplo_belo/src/models/product_model.dart';
import 'package:exemplo_belo/src/repositories/repository.dart';

class ProductsController extends Controller {
  ProductsController(this._repository);
  Repository _repository;

  List<Product>? _products, _filteredProducts;

  List<Product> get products => List.unmodifiable(_filteredProducts ?? []);

  Future<List<Product>> fetchProducts() async {
    _products = await _repository.getProducts();
    _filteredProducts = _products;
    return _products!;
  }

  void filterProducts(String filter) {
    setStatus(Status.loading);
    if (filter.isNotEmpty) {
      _filteredProducts = _products
          ?.where((product) =>
              product.name.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    } else {
      _filteredProducts = _products;
    }
    setStatus(Status.success);
  }
}
