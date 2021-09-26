import 'package:exemplo_belo/src/consts/palette.dart';
import 'package:exemplo_belo/src/pages/products_page.dart';
import 'package:exemplo_belo/src/pages/widgets/signup_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ProductsPage();
        } else if (snapshot.hasError) {
          return Scaffold(
            backgroundColor: Palette.primaryColor,
            body: Center(
              child: Text('Algo deu errado. Tente novamente!!'),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Palette.primaryColor,
            body: Center(
              child: CircularProgressIndicator(
                color: Palette.secondaryColor,
              ),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Palette.primaryColor,
            body: SignupWidget(),
          );
        }
      },
    );
  }
}
