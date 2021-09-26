import 'dart:io';

import 'package:exemplo_belo/src/controllers/auth.dart';
import 'package:exemplo_belo/src/controllers/products.dart';
import 'package:exemplo_belo/src/controllers/wishlist.dart';
import 'package:exemplo_belo/src/pages/home_page.dart';
import 'package:exemplo_belo/src/pages/products_page.dart';
import 'package:exemplo_belo/src/repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Directory dir = await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(dir.path);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (contex) => AuthController()),
        Provider(create: (context) => MockDataSourceImpl()),
        ProxyProvider<MockDataSourceImpl, RepositoryImpl>(
          update: (_, dataSource, __) => RepositoryImpl(dataSource),
        ),
        ChangeNotifierProxyProvider<RepositoryImpl, ProductsController>(
          create: (context) =>
              ProductsController(context.read<RepositoryImpl>()),
          update: (_, repo, controller) => ProductsController(repo),
        ),
        ChangeNotifierProvider(create: (context) => WishlistController()),
      ],
      child: MaterialApp(
        title: 'Exemplo Belo',
        home: HomePage(),
      ),
    );
  }
}
