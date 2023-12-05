import 'package:e_cantina_app/app_data/app_data.dart';
import 'package:e_cantina_app/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderUserScreenAdm extends StatefulWidget {
  const OrderUserScreenAdm({super.key});

  @override
  State<OrderUserScreenAdm> createState() => _OrderUserScreenAdmState();
}

class _OrderUserScreenAdmState extends State<OrderUserScreenAdm> {
  List<OrderModel> orders = [];

  @override
  void initState() {
    super.initState();
    final appData = Provider.of<AppData>(context, listen: false);
    appData.getOrderByIdEstablishment(1);
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
                                Text(appData.orders[index].nameUser.toString()),
                              ],
                            ),
                            trailing: Text(
                                'Total: R\$${appData.orders[index].total.toStringAsFixed(2)}'),
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
