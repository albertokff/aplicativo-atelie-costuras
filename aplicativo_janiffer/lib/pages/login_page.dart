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
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 850,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(96, 25, 26, 1),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(200)
                    )
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 300,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 50,
                          ),
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
                          SizedBox(
                            width: 50,
                          ),
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 50,
                          ),
                          Text(
                            "Ateliê de Ajustes",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )
                          )
                        ],
                      ),
                      InputField(hint: "Email", controller: emailController, icon: Icons.email),
                      InputField(hint: "Senha", controller: senhaController, icon: Icons.password),
                      const SizedBox(
                        height: 50,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 255, 255),                          
                          fixedSize: const Size(320, 50),
                        ),
                        onPressed: (){},
                        child: 
                        const Text(
                          "Entrar",
                        )
                      )
                    ]
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "@ Desenvolvido por Diogo Kirchoff",
                  style: TextStyle(
                    color: Color.fromRGBO(96, 25, 26, 1)),
                )],
            )
            ))
        ),
      );
  }
}