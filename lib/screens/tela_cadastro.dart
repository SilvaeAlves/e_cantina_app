import 'package:e_cantina_app/models/customer_model.dart';
import 'package:e_cantina_app/screens/tela_login.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _socialNameController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isAdm = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
                  Row(
                    children: [
                      const Text(
                        'Cadastro',
                        style: TextStyle(fontSize: 36.0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          children: [
                            Switch(
                                value: isAdm,
                                onChanged: (value) =>
                                    setState(() => isAdm = value)),
                            isAdm
                                ? const Text('Administrador')
                                : const Text('Cliente'),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 32.0),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Nome',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _socialNameController,
                decoration: const InputDecoration(
                  hintText: 'Nome Social',
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
              const SizedBox(height: 16.0),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Confirmação de senha',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.redAccent),
                onPressed: () {
                  if (_confirmPasswordController.text !=
                      _passwordController.text) {
                    _showErrorDialog(context);
                  } else {
                    CustomerModel customer = CustomerModel(
                        email: _emailController.text,
                        password: _passwordController.text,
                        name: _nameController.text,
                        socialName: _socialNameController.text,
                        id: CustomerModel.createId(),
                        isAdm: isAdm);
                    customer.saveCustomer().then((value) {
                      if (value) {
                        CustomerModel.saveCustomerUserLocal(customer);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      }
                    });
                  }
                },
                child: const Center(child: Text('Salvar')),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Verifique os dados informados'),
          content: const Text('Senhas não conferem.'),
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
