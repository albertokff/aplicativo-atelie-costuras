import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aplicativo_mancada/pages/login_page.dart';

class GamePage extends StatefulWidget {
  final String nomeJogadores;

  const GamePage({super.key, required this.nomeJogadores});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late List<String> nomes;
  Map<String, dynamic> pontuacao = {};
  int rodadaAtualIndex = 0;
  bool finalDePartida = false;
  String nomeVencedor = '';
  int pontosVencedor = 0;

  final List<String> rodadas = [
    '1 trinca \n 1 sequência',
    '2 trincas \n 1 sequência',
    '3 trincas',
    '2 trincas \n 1 sequência',
    '3 sequências',
    '2 sequências \n 2 trincas',
    '4 trincas',
    '3 sequências \n 1 trinca',
    '4 sequências',
  ];

  @override
  void initState() {
    super.initState();

    nomes = widget.nomeJogadores.split(',');
    pontuacao = {
      for (var nome in nomes) 
        nome.trim(): {
          'pontuacao': 0,
          'posicao': 0
        }
    };
  }

  void _proximaRodada() {
    debugPrint(rodadaAtualIndex.toString());
    if (rodadaAtualIndex == 1) {
        finalDePartida = true;
    } else {
      setState(() {
            if (rodadaAtualIndex < rodadas.length - 1) {
              rodadaAtualIndex++;
            } else {
              rodadaAtualIndex = 0;
            }
      });
    }
  }

  @override

  void dispose() {
    super.dispose();
  }

  List<TableRow> _buildTableRows() {
    var jogadoresOrdenados = pontuacao.entries.toList()
      ..sort((a, b) => a.value['posicao'].compareTo(b.value['posicao']));

    return jogadoresOrdenados.map((jogador) {
      return TableRow(children: [
        TableCell(
            child: Center(
                child: Text(
                    pontuacao[jogador.key]['posicao'].toString()))),
        TableCell(child: Center(child: Text(jogador.key))),
        TableCell(
            child: Center(
                child: Text(
                    pontuacao[jogador.key]['pontuacao'].toString()))),
      ]);
    }).toList();
  }

  void _modalFimPartida()
  {
    debugPrint('Modal chamada!');
    
    Map<String, TextEditingController> controladores = {};

    pontuacao.forEach((jogador, pontos) {
      controladores[jogador] = TextEditingController(text: '');
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Modal com os TextFields
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Final de Jogo!',
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          content:  SizedBox(
            height: 250, // Altura da modal
            child: SingleChildScrollView(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [const Text(
                'Parabéns ao vencedor dessa rodada:'
              ),
                Text(
                  '$nomeVencedor: $pontosVencedor'
              )]
            )),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text('Sair'),
            ),
            TextButton(
              onPressed: () {
                // Atualiza a pontuação de cada jogador
                pontuacao.forEach((nome, dados) {
                  int pontosRodada = int.tryParse(controladores[nome]!.text) ?? 0;

                  pontuacao.update(nome, (dados) {
                    return {
                      'pontuacao': dados['pontuacao'] + pontosRodada,
                      'posicao': dados['posicao']
                    };
                  });
                });

                setState(() {
                  var jogadoresOrdenados = pontuacao.entries.toList()
                    ..sort((a, b) => a.value['pontuacao'].compareTo(b.value['pontuacao']));

                  for (int i = 0; i < jogadoresOrdenados.length; i++) {
                    pontuacao[jogadoresOrdenados[i].key]['posicao'] = i + 1;
                  }

                  _proximaRodada();
                }); // Atualiza a tabela
                
                if (finalDePartida) {
                  Future.delayed(const Duration(milliseconds: 200), () {
                    _modalFimPartida(); // Abre a próxima modal automaticamente
                  });
                }

                Navigator.of(context).pop();
                _mostrarModal();
              },
              child: const Text('Jogar Novamente'),
            ),
          ],
        );
      });
  }

  void _modalAtualizarPontuacoes()
  {
    Map<String, TextEditingController> controladores = {};

    pontuacao.forEach((jogador, pontos) {
      controladores[jogador] = TextEditingController(text: '');
    });

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
            child: SingleChildScrollView(
              child: Column(
              mainAxisSize: MainAxisSize.min,
              children: pontuacao.keys.map((jogador) {
                return Padding( // Adicione Padding para espaçamento
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: controladores[jogador],
                    decoration: InputDecoration(
                      labelText: jogador,
                      border: const OutlineInputBorder(), // Adicione borda ao TextField
                    ),
                    keyboardType: TextInputType.number,
                  ),
                );
              }).toList(),
            )),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                // Atualiza a pontuação de cada jogador
                pontuacao.forEach((nome, dados) {
                  int pontosRodada = int.tryParse(controladores[nome]!.text) ?? 0;

                  pontuacao.update(nome, (dados) {
                    return {
                      'pontuacao': dados['pontuacao'] + pontosRodada,
                      'posicao': dados['posicao']
                    };
                  });
                });

                setState(() {
                  var jogadoresOrdenados = pontuacao.entries.toList()
                    ..sort((a, b) => a.value['pontuacao'].compareTo(b.value['pontuacao']));

                  for (int i = 0; i < jogadoresOrdenados.length; i++) {
                    pontuacao[jogadoresOrdenados[i].key]['posicao'] = i + 1;
                  }

                  nomeVencedor = jogadoresOrdenados.first.key;
                  pontosVencedor = jogadoresOrdenados.first.value['pontuacao'];

                  _proximaRodada();
                }); // Atualiza a tabela
                Navigator.of(context).pop();

                if (finalDePartida) {
                  Future.delayed(const Duration(milliseconds: 200), () {
                    _modalFimPartida(); // Abre a próxima modal automaticamente
                  });
                }
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarModal() {
     finalDePartida ? _modalFimPartida() : _modalAtualizarPontuacoes(); 
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
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
            Align(
              alignment: const Alignment(0, -0.5),
              child: Container(
                  width: 300, // Largura do retângulo
                  height: 100, // Altura do retângulo
                  decoration: BoxDecoration(
                    color: Colors.green, // Cor do retângulo
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
                    'Rodada Atual \n ${rodadas[rodadaAtualIndex]}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ),
            Align(
              alignment: const Alignment(0, 0.2),
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,                
                children: <Widget>[
                  Table(
                    border: TableBorder.all(
                      color: Colors.green,
                      width: 1.0,
                      style: BorderStyle.solid
                    ),
                    children: [
                      const TableRow(children: [
                        TableCell(
                          child: 
                            Center(
                              child: 
                                Text(
                                  'Ranking',
                                  style: 
                                    TextStyle(
                                      color: Colors.green,
                                      fontSize: 20
                                    )
                                )
                            )
                        ),
                        TableCell(
                          child: 
                            Center(
                              child: 
                                Text(
                                  'Jogador',
                                  style: 
                                    TextStyle(
                                      color: Colors.green,
                                      fontSize: 20
                                    )
                                )
                            )
                        ),
                        TableCell(
                          child: 
                            Center(
                              child: 
                                Text(
                                  'Pontuação',
                                  style: 
                                    TextStyle(
                                      color: Colors.green,
                                      fontSize: 20
                                    )
                                )
                            )
                        ),
                      ]),
                      ..._buildTableRows()
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
                  _mostrarModal();
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
            Align(
              alignment: const Alignment(0, 0.82),
              child: ElevatedButton(
                onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  'Sair',
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
