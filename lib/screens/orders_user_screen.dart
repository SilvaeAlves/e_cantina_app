import 'package:e_cantina_app/app_data/app_data.dart';
import 'package:e_cantina_app/config/app_config.dart';
import 'package:e_cantina_app/models/order_model.dart';
import 'package:e_cantina_app/screens/credicard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderUserScreen extends StatefulWidget {
  const OrderUserScreen({super.key});

  @override
  State<OrderUserScreen> createState() => _OrderUserScreenState();
}

class _OrderUserScreenState extends State<OrderUserScreen> {
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
            'Pedidos',
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
                        GestureDetector(
                          onTap: () {
                            if (appData.orders[index].isPago == false) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CredicardScreen(
                                            order: appData.orders[index],
                                          )));
                            }
                          },
                          child: Card(
                            color: appData.orders[index].isPago == false
                                ? Colors.redAccent
                                : Colors.greenAccent,
                            child: ListTile(
                              title: Text(
                                  'Pedido ${appData.orders[index].id.toString()}'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(appData.orders[index].idUser.toString()),
                                  Text(appData.orders[index].nameUser
                                      .toString()),
                                ],
                              ),
                              trailing: Text(
                                  'Total: R\$${appData.orders[index].total.toStringAsFixed(2)}'),
                            ),
                          ),
                        ),
                        for (var element in appData.orders[index].products)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 5),
                                child: SizedBox(
                                    width: 120, child: Text(element.name)),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Text(
                                    'Quantidade: ${element.quantity.toString()}'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child:
                                    Text(AppData.formatCurrency(element.price)),
                              ),
                            ],
                          ),
                        const Divider(
                          color: Colors.black26,
                          height: 25,
                          thickness: 2,
                        )
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
