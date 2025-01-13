import 'package:aplicativo_janiffer/components/input_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController(text: "");
  var senhaController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          dragStartBehavior: ,
          reverse: true,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 700,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(96, 25, 26, 1),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(200)
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 20
                      )
                    ]
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Janiffer",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.bold
                            )
                          )
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Favaretto",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.bold
                            )
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 55),
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            "Ateliê de Ajustes",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            )
                          )
                        ],
                      ),
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      InputField(hint: "Email", controller: emailController, icon: Icons.email),
                      InputField(hint: "Senha", controller: senhaController, icon: Icons.password),
                      const SizedBox(
                        height: 100,
                      ),
                      ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                          fixedSize: const Size(300 , 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)
                          )
                        ),
                        child: const Text("Entrar")),
                    ]
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "@ Desenvolvido por Diogo Kirchoff",
                  style: TextStyle(
                    color: Color.fromRGBO(96, 25, 26, 1),
                    fontWeight: FontWeight.bold),
                )],
            )
            ))
        ),
      );
  }
}