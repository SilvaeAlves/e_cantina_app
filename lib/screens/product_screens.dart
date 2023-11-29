import 'package:e_cantina_app/app_data/app_data.dart';
import 'package:e_cantina_app/config/app_config.dart';
import 'package:e_cantina_app/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        actions: [
          Consumer(builder: (context, AppData appData, child) {
            if (appData.cart.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_cart),
                      Text(
                        appData.cart.length.toString(),
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartScren()));
                  },
                ),
              );
            } else {
              return const Row(
                children: [],
              );
            }
          }),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          for (var product in appData.products)
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.20,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppConfig.bodyColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: ClipOval(
                            child: Image.asset(
                              product.image,
                              fit: BoxFit.cover,
                              width: 75,
                              height: 100,
                            ),
                          ),
                          title: Text(product.name),
                          subtitle: Text(product.description),
                          trailing: Text(AppData.formatCurrency(product.price)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.add_shopping_cart),
                                onPressed: () {
                                  appData.addToCart(product);
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Text(product.quantity.toString()),
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove_shopping_cart),
                                onPressed: () {
                                  appData.removeFromCart(product);
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
        ],
      )),
    );
  }
}
