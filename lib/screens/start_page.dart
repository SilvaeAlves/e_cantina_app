import 'package:e_cantina_app/config/app_config.dart';
import 'package:e_cantina_app/screens/tela_cadastro.dart';
import 'package:e_cantina_app/screens/tela_login.dart';
import 'package:flutter/material.dart';

class Startpage extends StatefulWidget {
  const Startpage({super.key});

  @override
  State<Startpage> createState() => _StartpageState();
}

class _StartpageState extends State<Startpage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConfig.backgroundColorStartPage,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 55.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    50.0), // Ajuste o valor conforme necessário
                child: Image.asset('assets/images/ativo_6@300x.png'),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: SizedBox(
                  height: 50.0,
                  width: 150.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text('Login'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  //alterado para 8 pois ja tem 8 de padding do padding que antecede ai fica no padrão 16 e não quebra em telas menores
                  vertical: 8.0,
                ),
                child: SizedBox(
                  height: 50.0,
                  width: 150.0,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: const Text('Cadastro')),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
