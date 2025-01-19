import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aplicativo_mancada/pages/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var nomeJogadoresController = TextEditingController(text: "");

  @override
  build(BuildContext context) {
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
                  width: 150, // Largura do retângulo
                  height: 70, // Altura do retângulo
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
                    fontSize: 20,
                    color: Colors.green[600],
                    fontWeight: FontWeight.bold,
                  ),
                ),)
              )
            ),
            const Align(
              alignment: Alignment(0, -0.4),
              child: Text(
                'Antes de começar, \ninforme o nome dos jogadores, \nseparados por vírgula:',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              )
            ),
            Align(
              alignment: const Alignment(0, -0.1),
              child: Container(
                width: 300, // Largura do retângulo
                height: null, // Altura do retângulo
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
                child: TextField(
                  controller: nomeJogadoresController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  minLines: 5,
                ),
              )
            ),
            Align(
              alignment: const Alignment(0, 0.7), // Botão mais para baixo
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  backgroundColor: Colors.green[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  debugPrint("Jogadores: ${nomeJogadoresController.text}");
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GamePage(nomeJogadores: nomeJogadoresController.text,)));
                },
                child: const Text('JOGAR',
                  style: TextStyle(
                    fontSize: 60,
                    color: Colors.white
                  ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}