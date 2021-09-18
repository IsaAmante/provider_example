import 'package:exemplo_belo/src/controllers/products.dart';
import 'package:exemplo_belo/src/pages/products_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductsController()),
      ],
      child: MaterialApp(
        title: 'Exemplo Belo',
        home: ProductsPage(),
      ),
    );
  }
}
