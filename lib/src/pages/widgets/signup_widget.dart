import 'package:exemplo_belo/src/consts/palette.dart';
import 'package:exemplo_belo/src/controllers/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      // color: Palette.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<AuthController>(builder: (context, controller, _) {
            if (controller.isLoading)
              return CircularProgressIndicator(color: Palette.headerElements);
            return ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Palette.headerElements,
                onPrimary: Palette.text,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
              ),
              onPressed: () {
                controller.signInWithGoogle();
              },
              icon: FaIcon(
                FontAwesomeIcons.google,
                color: Palette.text,
              ),
              label: Text('Entrar com conta do Google'),
            );
          }),
        ],
      ),
    );
  }
}
