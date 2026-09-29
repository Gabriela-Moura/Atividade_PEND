import 'package:flutter/material.dart';

void main() {
  runApp(const SucessoScreen());
}

class SucessoScreen extends StatelessWidget {
  const SucessoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'Hello World!',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}