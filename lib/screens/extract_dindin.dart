import 'package:e_cantina_app/config/app_config.dart';
import 'package:e_cantina_app/models/customer_model.dart';
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
  CustomerModel customer = CustomerModel(
      id: 0, name: '', socialName: '', email: '', password: '', isAdm: false);

  @override
  void initState() {
    getOrders();
    super.initState();
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
              Text(
                'Movimento Finaceiro: R\$ ${appData.caixa.toString()}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
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
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(appData.orders[index].idUser
                                            .toString()),
                                        Text(appData.orders[index].nameUser,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
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
                                  onPressed: () {
                                    confirmDeleteOrder(context,
                                        appData.orders[index].id, appData);
                                  },
                                  child: const Center(
                                      child: Text(
                                    'Cancelar Compra',
                                    style: TextStyle(color: Colors.white),
                                  )),
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

  Future<void> getOrders() async {
    await CustomerModel.getCustomerUserLocal().then((value) {
      customer = value;
      if (customer.isAdm == true) {
        OrderModel.getOrdersByIdStablishment(1);
      } else {
        OrderModel.getOrdersByIdUser(customer.id);
      }
    });
  }

  void confirmDeleteOrder(BuildContext context, int id, AppData appData) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancelar Pedido'),
          content: const Text('Certeza que deseja excluir pedido'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: () {
                OrderModel.deleteOrder(id);
                Navigator.of(context).pop();
                appData.getOrderByIdEstablishment(1);
              },
              child: const Text('Sim'),
            ),
          ],
        );
      },
    );
  }
}
