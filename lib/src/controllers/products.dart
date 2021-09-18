import 'package:exemplo_belo/src/controllers/controller.dart';

class ProductsController extends Controller {
  ProductsController() : _text = 'Clique para começar...';
  String _text;
  bool _switcher = false;

  Map<bool, String> _texts = {
    true: "O texto...",
    false: "...muda!",
  };

  String get text => _text;

  // Quando usamos algum await, é necessário usar
  // o async.
  changeText() async {
    setStatus(Status.loading);

    // Esse delayed é só pra dar tempo de aparecer
    // o carregamento na tela.
    await Future.delayed(Duration(seconds: 1));

    _switcher = !_switcher;
    _text = _texts[_switcher]!;

    setStatus(Status.success);
  }

  secretChangeText() {
    _switcher = false;
    setStatus(Status.batatinha);
  }
}
