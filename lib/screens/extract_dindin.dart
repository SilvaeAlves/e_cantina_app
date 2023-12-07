import 'package:e_cantina_app/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:e_cantina_app/app_data/app_data.dart';
import 'package:e_cantina_app/models/order_model.dart';
import 'package:provider/provider.dart';

class ExtractDindin extends StatefulWidget {
  const ExtractDindin({super.key});

  @override
  State<ExtractDindin> createState() => _OrderUserScreenState();
}

class _OrderUserScreenState extends State<ExtractDindin> {
  List<OrderModel> orders = [];

  @override
  void initState() {
    super.initState();
    final appData = Provider.of<AppData>(context, listen: false);
    appData.getOrdersByIdUser();
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Extrato Dindin',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: AppConfig.backgroundColorStartPage,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: appData.orders.length,
                itemBuilder: (context, index) {
                  return Expanded(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Column(
                              children: [
                                Card(
                                  child: ListTile(
                                    title: Text(
                                        'Extrato do Pedido: ${appData.orders[index].id.toString()}'),
                                    subtitle: Text(appData.orders[index].idUser
                                        .toString()),
                                    trailing: Text(
                                        appData.orders[index].total.toString()),
                                  ),
                                ),
                                for (var element
                                    in appData.orders[index].products)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25, vertical: 5),
                                        child: SizedBox(
                                            width: 120,
                                            child: Text(element.name)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: Text(
                                            'Quantidade: ${element.quantity.toString()}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 25),
                                        child: Text(AppData.formatCurrency(
                                            element.price)),
                                      ),
                                    ],
                                  ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.redAccent),
                                  onPressed: () {},
                                  child: const Center(
                                      child: Text('Cancelar Compra')
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black26,
                                  height: 25,
                                  thickness: 2,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
