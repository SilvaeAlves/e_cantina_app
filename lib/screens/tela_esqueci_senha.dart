// ignore_for_file: library_private_types_in_public_api

import 'package:e_cantina_app/config/app_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeForgetPassword extends StatefulWidget {
  const HomeForgetPassword({super.key});

  @override
  _LoginPasswordState createState() => _LoginPasswordState();
}

class _LoginPasswordState extends State<HomeForgetPassword> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConfig.backgroundColorStartPage,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(width: 16.0),
                const Text(
                  'Recuperar Senha',
                  style: TextStyle(fontSize: 33.0),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'e_mail',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32.0),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.redAccent),
                  onPressed: () async {
                    try {
                      await resetPassword(_emailController.text);
                    } catch (e) {
                      _showErrorDialog(context); // Use o contexto passado no parâmetro
                    }
                  },
                  child: const Center(child: Text('Redefinir Senha'))),
            ),
          ],
        ),
      ),
    );
  }


  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro de Autenticação'),
          content: const Text(
              'E-mail incorreto. Por favor, tente novamente.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // Envio de e-mail bem-sucedido
      print("Um e-mail de redefinição de senha foi enviado para $email");
    } catch (e) {
      _showErrorDialog(context);
    }
  }


}
