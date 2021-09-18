import 'package:exemplo_belo/src/controllers/products.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  _ProducsPageState createState() => _ProducsPageState();
}

class _ProducsPageState extends State<ProductsPage>
    with TickerProviderStateMixin {
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Os controller de animação devem ser disposed.
    // No caso do Provider (ProductsController), não é
    // necessário dar dispose, pois o MultiProvider lá
    // no main lida com isso :)
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        backgroundColor: Colors.greenAccent,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
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
                                color: _iconColor,
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
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          // Aqui usei um setState só para mostrar como ele funciona,
          // mas também seria possível colocar o Icon dentro
          // de um Consumer, já que usamos o secretChangeText() logo depois
          setState(() {
            _iconColor = Colors.redAccent;
          });
          Provider.of<ProductsController>(context, listen: false)
              .secretChangeText();
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
    );
  }
}
