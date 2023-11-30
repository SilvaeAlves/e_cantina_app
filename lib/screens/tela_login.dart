// ignore_for_file: library_private_types_in_public_api

import 'package:e_cantina_app/models/customer_model.dart';
import 'package:e_cantina_app/screens/product_screens.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
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
                  'Login',
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
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Senha',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32.0),
            Center(
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: () {
                  login(_emailController.text, _passwordController.text)
                      .then((value) {
                    if (value) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const ProductsScreen(),
                        ),
                      );
                    } else {
                      _showErrorDialog(context);
                    }
                  });
                },
                child: const Center(child: Text('Login')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> login(String email, String password) async {
    CustomerModel customer =
        await CustomerModel.getCustomerByEmailAndPassword(email, password);
    if (customer.id != 0) {
      return true;
    } else {
      return false;
    }
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro de Autenticação'),
          content: const Text(
              'E-mail ou senha incorretos. Por favor, tente novamente.'),
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
}
