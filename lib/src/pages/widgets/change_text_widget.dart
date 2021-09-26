/* import 'package:exemplo_belo/src/controllers/products.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangeTextWidget extends StatelessWidget {
  const ChangeTextWidget({Key? key, required this.iconColor}) : super(key: key);

  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          // O Consumer reconstrói o widget quando o provider
          // correspondente chama notifyListener
          Consumer<ProductsController>(
            builder: (context, productsController, _) {
              String text = (productsController.hasSuccess ||
                      productsController.isInitial)
                  ? productsController.text
                  : 'Não foi possível trocar o texto!';

              // A ideia aqui pe mostrar o uso dos states
              // na hora de construir uma tela.
              return (productsController.isLoading)
                  ? CircularProgressIndicator(color: Colors.redAccent)
                  : productsController.isBatatinha
                      ? Column(
                          children: [
                            // Aqui eu poderia deixar melhor, já que estou repetindo códigos...
                            Icon(
                              Icons.favorite,
                              color: iconColor,
                              size: 100,
                            ),
                            Text(
                              'Obrigada',
                              style: GoogleFonts.rubik(
                                color: Colors.redAccent,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          text,
                          style: GoogleFonts.rubik(
                            color: Colors.redAccent,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        );
            },
          ),
          Spacer(),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color?>(Colors.redAccent),
              fixedSize: MaterialStateProperty.all<Size?>(Size(200, 40)),
            ),
            onPressed: () {
              // Já o Provider.of com o listen: false só acessa as informações
              // do provider, mas este widget não será reconstruído, somente os
              // que estiverem dentro de Consumers.
              Provider.of<ProductsController>(context, listen: false)
                  .changeText();
            },
            child: Text('Click Me'),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
 */