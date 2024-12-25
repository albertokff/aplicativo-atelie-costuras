import 'package:flutter/material.dart';
import 'package:aplicativo_janiffer/components/input_field.dart';
import 'package:aplicativo_janiffer/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var usuarioController = TextEditingController(text: "");
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Image.asset('lib/assets/images/logo_janiffer.jpeg'),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Ateliê de Ajustes",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Entre e tenha acesso a todos os recursos",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red)
                ),
                const SizedBox(
                  height: 40
                ),
                InputField(hint: 'Usuário', controller: usuarioController, icon: Icons.person),
                InputField(hint: 'Senha', controller: senhaController, icon: Icons.password,),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));
                      },
                      child: const Text(
                        "ENTRAR",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                  ))
                )
            )],
            )
            ))
        ),
      );
  }
}