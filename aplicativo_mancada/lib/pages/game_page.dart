import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GamePage extends StatefulWidget {
  final String nomeJogadores;

  const GamePage({super.key, required this.nomeJogadores});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late Map<String, TextEditingController> pontuacao;
  late List<String> nomes;

  @override
  void initState() {
    super.initState();

    nomes = widget.nomeJogadores.split(',');
    pontuacao = {
      for (var nome in nomes) 
        nome.trim(): TextEditingController(text: '0')
    };
  }

  @override
  void dispose() {
    for (var controller in pontuacao.values) {
      controller.dispose();
    }
    super.dispose();
  }

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
                  ),
                ),
              ),
            ),
            const Align(
              alignment: Alignment(0, -0.5),
              child: Text(
                'Rodada atual',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Align(
              alignment: Alignment(0, -0.4),
              child: Text(
                '- 1 Trinca \n- 2 Sequências',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.2),
              child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Table(
                  border: TableBorder.all(
                    color: Colors.green,
                    width: 2,
                  ),
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(1),
                  },
                  children: [
                    const TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Posição',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Jogadores',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Pontos',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.green),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    for (var nome in nomes)
                      TableRow(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              '0',
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              nome.trim(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              pontuacao[nome.trim()]?.text ?? '0',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: const Alignment(0, 0.7),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // Modal com os TextFields
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: const Text(
                          'Atualize os pontos',
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        content: SizedBox(
                          height: 500, // Altura da modal
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (var nome in nomes)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: pontuacao[nome.trim()],
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: nome.trim(),
                                      border: const OutlineInputBorder(),
                                    ),
                                    onChanged: (String valor) {
                                      debugPrint('nome considerado: $nome.trim()');
                                      final int novoValor = int.tryParse(valor) ?? 0; 
                                      pontuacao[nome.trim()]?.text = (int.tryParse(pontuacao[nome.trim()]!.text) !+ novoValor).toString(); 
                                    },
                                    
                                  ),
                                ),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () {
                              setState(() {
                                for (var nome in nomes) {
                                  pontuacao[nome.trim()]?.text = '0';
                                }
                              });
                              Navigator.of(context).pop(); // Fecha a modal
                            },
                            child: const Text('Cancelar'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            onPressed: () {
                              // debugPrint(pontuacao.toString());
                              setState(() {});

                              // Navigator.of(context).pop(); // Fecha a modal
                            },
                            child: const Text('Salvar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Colors.green,
                ),
                child: const Text(
                  'Próxima Rodada',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
