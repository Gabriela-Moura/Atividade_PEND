import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:exemplo_login/main.dart';
import 'package:exemplo_login/sucesso_screen.dart';

void main() {
  runApp(LoginScreen());
}

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final logincontrollerForm = TextEditingController();
  final senhacontrollerForm = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> fazerLogin(BuildContext context) async {
  final response = await http.get(
    Uri.parse(
      "http://10.140.169.8/backend_login/login.php"
      "?nome=${Uri.encodeComponent(logincontrollerForm.text)}"
      "&senha=${Uri.encodeComponent(senhacontrollerForm.text)}",
    ),
  );

  print("STATUS: ${response.statusCode}");
  print("RESPOSTA: '${response.body}'");

  if (response.statusCode == 200 && response.body.isNotEmpty) {
    final dados = jsonDecode(response.body);

    print(dados);

    if (dados["success"] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SucessoScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(dados["mensagem"]),
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Erro ao acessar o servidor"),
      ),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 85, 64),
      body: SafeArea(
        child: Center(
          child: Container(
            height: 450,
            width: 350,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color.fromARGB(163, 220, 220, 220),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  //   TEXTFORMFIELD COM VALIDAÇÃO
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Text(
                          "Login:",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),

                        TextFormField(
                          controller: logincontrollerForm,
                          decoration: InputDecoration(
                            labelText: "Nome",
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Campo obrigatório";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20),

                        Text(
                          "Senha:",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),

                        TextFormField(
                          controller: senhacontrollerForm,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Color.fromARGB(255, 255, 255, 255),
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Campo obrigatório";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 10),

                        SizedBox(height: 10),

                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await fazerLogin(context);
                            }
                          },

                          child: const Text(
                            "Entrar",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),

                        SizedBox(height: 30),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => MyApp()),
                            );
                          },

                          child: const Text("Voltar"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
