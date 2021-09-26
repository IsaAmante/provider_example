import 'package:exemplo_belo/src/consts/palette.dart';
import 'package:exemplo_belo/src/pages/products_page.dart';
import 'package:exemplo_belo/src/pages/widgets/signup_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProductsPage();
          } else if (snapshot.hasError) {
            return Text('Something went wrong...');
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Palette.secondaryColor,
              ),
            );
          } else {
            return SignupWidget();
          }
        },
      ),
    );
  }
}
