import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Row(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: double.infinity,
                  width: 50,
                  color: Colors.green[600],
                )
              ),
              Flexible(
                flex: 8,
                child: Container(                    
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 300,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                        'Mancada',
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          
                        )
                      ),
                      ),
                      const SizedBox(
                        height: 200
                      ),
                      ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          shadowColor: Colors.green[600],
                          elevation: 4
                        ),
                        child: const Text(
                          'JOGAR',
                          style: TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          )
                        )
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        shadowColor: Colors.green[600],
                        elevation: 4
                      ),
                      child: const Text(
                        'HISTÓRICO',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )
                      )),
                      const SizedBox(
                        height: 200,
                      ),
                      Text(
                        '@ Desenvolvido por Diogo Kirchoff',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green[600]
                        ),
                      )
                    ]
                  )
                )),
              Flexible(
                flex: 1,
                child: Container(
                  height: double.infinity,
                  width: 50,
                  color: Colors.green[600],
                )
              )
            ]
        )
        ))
      ));
  }
}