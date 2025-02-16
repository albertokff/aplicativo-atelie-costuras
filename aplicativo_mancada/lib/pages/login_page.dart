import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aplicativo_mancada/pages/home_page.dart';
import 'package:aplicativo_mancada/pages/howgame_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            // Coluna principal com os Flexibles
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(color: Colors.green[600]),
                ),
                Flexible(
                  flex: 8,
                  child: Container(color: Colors.white),
                ),
                Flexible(
                  flex: 1,
                  child: Container(color: Colors.green[600]),
                ),
              ],
            ),
            // Retângulo flutuante
            Align(
              alignment: const Alignment(0, -0.7),
              child: Transform.rotate(
                angle: -0.1,
                child: Container(
                  width: 375, // Largura do retângulo
                  height: 100, // Altura do retângulo
                  decoration: BoxDecoration(
                    color: Colors.white, // Cor do retângulo
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green), // Bordas arredondadas
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4), // Sombra para dar destaque
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                  'MANCADA',
                  style: TextStyle(
                    fontSize: 70,
                    color: Colors.green[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),)
              )
            ),
            Align(
              alignment: const Alignment(0, 0), // Botão mais para baixo
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.green[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
                },
                child: const Text('INICIAR',
                  style: TextStyle(
                    fontSize: 60,
                    color: Colors.white
                  ),
              ),
            )),
            Align(
              alignment: const Alignment(0, 0.3), // Botão mais para baixo
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.green[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HowGamePage()));
                },
                child: const Text('Como jogar?',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white
                  ),
              ),
            )),
            const Align(
              alignment: Alignment(0, 0.8), // Botão mais para baixo
              child: Text(
                '@ Desenvolvido por DARK Sistemas',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.green
                ),
              )),
          ],
        ),
      ),
    );
  }
}