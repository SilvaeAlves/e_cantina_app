import 'package:e_cantina_app/config/app_config.dart';
import 'package:e_cantina_app/screens/extract_dindin.dart';
import 'package:e_cantina_app/screens/orders_user_screen.dart';
import 'package:e_cantina_app/screens/product_screens.dart';
import 'package:e_cantina_app/screens/tela_login.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppConfig.backgroundColorStartPage,
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: IconButton(
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
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
                    return const ProductsScreen();
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
                            'assets/images/produtos.jpeg',
                            fit: BoxFit.cover,
                            width: 150,
                            height: 150,
                          ),
                        ),
                        const Text('Produtos'),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const OrderUserScreen();
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
                        const Text('Extrato Dindin'),
                      ],
                    ),
                  ),
                ),
              )
            ])));
  }
}
