import 'package:e_cantina_app/app_data/app_data.dart';
import 'package:e_cantina_app/config/app_config.dart';
import 'package:e_cantina_app/models/customer_model.dart';
import 'package:e_cantina_app/models/order_model.dart';
import 'package:e_cantina_app/models/product_model.dart';
import 'package:e_cantina_app/screens/cancel_order_screen.dart';
import 'package:e_cantina_app/screens/credicard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmOrderUser extends StatefulWidget {
  const ConfirmOrderUser({super.key, required this.order});
  final OrderModel order;

  @override
  State<ConfirmOrderUser> createState() => _ConfirmOrderUserState();
}

class _ConfirmOrderUserState extends State<ConfirmOrderUser> {
  bool isPix = false;
  bool isDinDin = false;
  var total = 0.0;

  late CustomerModel customer;

  void setTotal(List<ProductModel> products) {
    total = 0.0;
    for (var element in products) {
      total += element.price * element.quantity;
      if (total < 0) {
        total = 0.0;
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    CustomerModel.getCustomerUserLocal().then((value) {
      customer = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context);
    setTotal(appData.cart);
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 75.0,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
              width: 400.0,
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CancelOrderUser(
                                order: widget.order,
                              )));
                },
                child: const Text('Cancelar',
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Carrinho',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppConfig.backgroundColorStartPage,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          for (ProductModel p in widget.order.products)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child:
                                      SizedBox(width: 120, child: Text(p.name)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: Text(
                                      'Quantidade: ${p.quantity.toString()}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Text(AppData.formatCurrency(p.price)),
                                ),
                              ],
                            ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Preço Total: R\$${widget.order.total}',
                            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          //Text(
                            //AppData.formatCurrency(total),
                            //style: const TextStyle(fontSize: 20.0),
                          //),
                          Text(
                            'Forma de Pagamento: ${widget.order.paymentMethod}',
                            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Status: ${widget.order.status}',
                            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Número do pedido:\n ${widget.order.numberOrder}',
                    style: const TextStyle(
                        fontSize: 35.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Em caso de cancelamento do pedido, o valor fica de de crédito na conta do usuário em forma de Dindin.',
                    style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
