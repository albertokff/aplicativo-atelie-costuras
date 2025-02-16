import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aplicativo_mancada/pages/home_page.dart';

class HowGamePage extends StatelessWidget {
  const HowGamePage({super.key});

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
              alignment: const Alignment(0, -0.9),
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
              alignment: const Alignment(0, 0.5),
              child: Container(
                margin: EdgeInsets.only(left: 50, right: 50),
                width: 375,
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        'Como jogar',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        'O jogo é composto por 9 rodadas, em que o vencedor é o que tiver a MENOR pontuação após a última rodada.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 20),
                    const Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        ' -> 1 trinca e 1 sequência \n -> 2 trincas e 1 sequência \n -> 3 trincas \n -> 2 trincas e 1 sequência \n -> 3 sequências \n -> 2 sequências e 2 trincas \n -> 4 trincas \n -> 3 sequências e 1 trinca \n -> 4 sequências',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        '# Trinca: Três cartas do mesmo número, de naipes diferentes. Exemplo: 7♠ 7♦ 7♣ \n\n# Sequência: Três ou mais cartas do mesmo naipe em ordem crescente. Exemplo: 4♠ 5♠ 6♠',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        minimumSize: const Size(150, 50),
                      ),
                      child: const Text(
                        'Jogar',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}