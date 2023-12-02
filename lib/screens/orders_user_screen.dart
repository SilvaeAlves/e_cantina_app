import 'package:e_cantina_app/app_data/app_data.dart';
import 'package:e_cantina_app/models/order_model.dart';
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
          backgroundColor: Colors.redAccent,
          title: const Text('Pedidos'),
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
                        Card(
                          child: ListTile(
                            title: Text(
                                'Pedido ${appData.orders[index].id.toString()}'),
                            subtitle:
                                Text(appData.orders[index].idUser.toString()),
                            trailing:
                                Text(appData.orders[index].total.toString()),
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
