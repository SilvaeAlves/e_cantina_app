import 'package:e_cantina_app/screens/extract_dindin.dart';
import 'package:e_cantina_app/screens/orders_user_screen.dart';
import 'package:e_cantina_app/screens/orders_user_screen_adm.dart';
import 'package:e_cantina_app/screens/tela_login.dart';
import 'package:flutter/material.dart';

class HomeScreenAdm extends StatefulWidget {
  const HomeScreenAdm({super.key});

  @override
  State<HomeScreenAdm> createState() => _HomeScreenAdmState();
}

class _HomeScreenAdmState extends State<HomeScreenAdm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: const Text('Home'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoginScreen();
                  }));
                },
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
            child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                padding: const EdgeInsets.all(15),
                children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const OrderUserScreenAdm();
                  }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/images/pedidos.jpeg',
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                          ),
                        ),
                        const Text('Pedidos'),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ExtractDindin();
                  }));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            'assets/images/dindin.webp',
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                          ),
                        ),
                        const Text('Caixa'),
                      ],
                    ),
                  ),
                ),
              )
            ])));
  }
}