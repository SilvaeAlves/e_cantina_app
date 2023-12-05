import 'package:e_cantina_app/screens/tela_login.dart';
import 'package:flutter/material.dart';

class ForgetPasswordPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();


  ForgetPasswordPage({super.key});

  void _restPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text ('Esqueci a Senha'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
                onPressed: () => _restPassword(context)
                child: Text ('Esqueci a senha'),
            ),
            const SizedBox(height: 16.0,),
      TextButton(
        onPressed:(){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen(),
          );
        },
        child: const Text('Você não Lembra sua senha? Clique aqui!'),
      ),
        ],
      ),
    )
    );
  }
}

