import 'package:aplicativo_mancada/pages/home_page.dart';
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
    if (rodadaAtualIndex == 8) {
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
    int posicao = pontuacao[jogador.key]['posicao'];
    int pontuacaoJogador = pontuacao[jogador.key]['pontuacao'];

    Color posicaoColor;
    Icon posicaoIcon;

    // Atribuindo cores e ícones para as posições
    if (posicao == 1) {
      posicaoColor = Colors.amber; // Ouro para o 1º lugar
      posicaoIcon = const Icon(Icons.emoji_events, color: Colors.amber);
    } else if (posicao == 2) {
      posicaoColor = Colors.grey; // Prata para o 2º lugar
      posicaoIcon = const Icon(Icons.emoji_events, color: Colors.grey);
    } else if (posicao == 3) {
      posicaoColor = Colors.brown; // Bronze para o 3º lugar
      posicaoIcon = const Icon(Icons.emoji_events, color: Colors.brown);
    } else {
      posicaoColor = Colors.green[600]!; // Verde para os outros lugares
      posicaoIcon = const Icon(Icons.star_border, color: Colors.green); 
    }

    return TableRow(
      decoration: BoxDecoration(
        color: posicao % 2 == 0 ? Colors.green[50] : Colors.white, // Alternando cores de linha
        border: Border(bottom: BorderSide(color: Colors.green[300]!, width: 1)),
      ),
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                posicaoIcon,
                const SizedBox(width: 5),
                Text(
                  posicao.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: posicaoColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                jogador.key,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                pontuacaoJogador.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: pontuacaoJogador > 50 ? Colors.green[700] : Colors.black, // Destacando pontuação alta
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }).toList();
}


  void _modalFimPartida()
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
    borderRadius: BorderRadius.circular(16),
  ),
  backgroundColor: Colors.white,
  title: const Column(
    children: [
      Icon(Icons.emoji_events, color: Colors.amber, size: 50), // Ícone de troféu
      SizedBox(height: 10),
      Text(
        '🎉 Final de Jogo! 🎉',
        style: TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  ),
  content: SizedBox(
    height: 130,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Parabéns ao vencedor dessa rodada:',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                '🏆 $nomeVencedor',
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                'Pontuação: $pontosVencedor',
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
  actionsAlignment: MainAxisAlignment.spaceEvenly,
  actions: [
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
      child: const Text('Fechar', style: TextStyle(color: Colors.white)),
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
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Atualizar Pontos',
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: 400, // Ajustado para melhor proporção
            width: 350,  // Largura definida para um layout mais equilibrado
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: pontuacao.keys.map((jogador) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: controladores[jogador],
                      decoration: InputDecoration(
                        labelText: jogador,
                        labelStyle: const TextStyle(fontSize: 18, color: Colors.green),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        filled: true,
                        fillColor: Colors.green[50], // Fundo leve para destaque
                        prefixIcon: const Icon(Icons.score, color: Colors.green),
                      ),
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // Cor de destaque para cancelar
                textStyle: const TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
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
                    ..sort((a, b) => b.value['pontuacao'].compareTo(a.value['pontuacao']));

                  for (int i = 0; i < jogadoresOrdenados.length; i++) {
                    pontuacao[jogadoresOrdenados[i].key]['posicao'] = i + 1;
                  }

                  nomeVencedor = jogadoresOrdenados.first.key;
                  pontosVencedor = jogadoresOrdenados.first.value['pontuacao'];

                  _proximaRodada();
                });

                Navigator.of(context).pop();

                if (finalDePartida) {
                  Future.delayed(const Duration(milliseconds: 200), () {
                    _modalFimPartida(); // Abre a próxima modal automaticamente
                  });
                }
              },
              child: const Text(
                'Confirmar',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
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
              child: Container(color: Colors.green[800]), // Cor mais forte
            ),
            Flexible(
              flex: 8,
              child: Container(color: Colors.white),
            ),
            Flexible(
              flex: 1,
              child: Container(color: Colors.green[800]),
            ),
          ],
        ),
        // Retângulo flutuante
        Align(
          alignment: const Alignment(0, -0.95),
          child: Transform.rotate(
            angle: -0.1,
            child: Container(
              width: 160, // Largura do retângulo aumentada
              height: 80, // Altura do retângulo aumentada
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                'MANCADA',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Align(
  alignment: const Alignment(0, -0.6),
  child: Container(
    width: 300,
    height: 130,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF2E7D32), Color(0xFF66BB6A)], // Tons de verde
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white.withOpacity(0.6), width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 12,
          spreadRadius: 2,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Rodada Atual',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        Text(
          rodadas[rodadaAtualIndex],
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.w900,
            shadows: [
              Shadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(1, 2),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  ),
),

        Align(
          alignment: const Alignment(0, 0.6), // Alterado para mover a tabela mais para baixo
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Adicionando Padding para espaçar a tabela mais para baixo
                const SizedBox(height: 100),
                Table(
                      columnWidths: const {
                        0: FixedColumnWidth(60),
                        1: FixedColumnWidth(180),
                        2: FixedColumnWidth(60),
                      },
                      border: TableBorder.all(
                        color: Colors.green,
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                      children: const [
                        TableRow(children: [
                          TableCell(
                            child: Center(
                              child: Text(
                                'Pos',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text(
                                'Jogador',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text(
                                'Pont',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ), // Espaçamento adicional acima da tabela
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 330, // Tamanho fixo para a tabela
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Table(
                      columnWidths: const {
                        0: FixedColumnWidth(60),
                        1: FixedColumnWidth(180),
                        2: FixedColumnWidth(60),
                      },
                      border: TableBorder.all(
                        color: Colors.green,
                        width: 1.5,
                        style: BorderStyle.solid,
                      ),
                      children: _buildTableRows(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        !finalDePartida ? Align(
          alignment: const Alignment(0, 0.7),
          child: ElevatedButton(
            onPressed: () {
              _mostrarModal();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.green,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: const Text(
              'Próxima Rodada',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ) : const Align(),
        Align(
          alignment: const Alignment(0, 0.9),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: Colors.red[600],
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
            ),
            child: const Text(
              'Sair',
              style: TextStyle(
                fontSize: 14,
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