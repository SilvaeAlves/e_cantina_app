import 'package:e_cantina_app/app_data/app_data.dart';
import 'package:e_cantina_app/config/app_config.dart';
import 'package:e_cantina_app/models/customer_model.dart';
import 'package:e_cantina_app/models/order_model.dart';
import 'package:e_cantina_app/models/product_model.dart';
import 'package:e_cantina_app/screens/confirm_order_user.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScren extends StatefulWidget {
  const CartScren({super.key});

  @override
  State<CartScren> createState() => _CartScrenState();
}

class _CartScrenState extends State<CartScren> {
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
        height: 150.0,
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
              width: double.infinity,
              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                onPressed: () async {
                  if (isDinDin == false && isPix == false) {
                    selectPaymentMethod(context);
                  } else {
                    if (appData.cart.isNotEmpty) {
                      OrderModel order = appData.createOrder();

                      for (var element in appData.cart) {
                        appData.addProductToOrder(order, element);
                      }
                      if (isDinDin) {
                        order.paymentMethod = 'DinDin';
                      }
                      if (isPix) {
                        order.paymentMethod = 'Pix';
                      }

                      if (customer.id != 0) {
                        order.idUser = customer.id;
                        order.nameUser = customer.name;
                        order.isPago = true;
                        order.status = 'Pago';

                        OrderModel.saveOrder(order);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ConfirmOrderUser(
                                      order: order,
                                    )));
                      }
                    }
                  }
                },
                child: const Text('Pagar',
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
        backgroundColor: AppConfig.backgroundColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 2.0,
            ),
          ),
          child: Column(
            children: [
              for (ProductModel product in appData.cart)
                ListTile(
                  leading: ClipOval(child: Image.asset(product.image)),
                  title: Text(product.name),
                  subtitle: Text(ProductModel.priceTotal(product)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          appData.addToCart(product);
                          setTotal(appData.cart);
                        },
                      ),
                      Consumer(builder: (context, AppData appData, child) {
                        return Text(
                          product.quantity.toString(),
                          style: const TextStyle(fontSize: 20.0),
                        );
                      }),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          appData.removeFromCart(product);
                          setTotal(appData.cart);
                        },
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(left: 150),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Preço Total:',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    Text(
                      AppData.formatCurrency(total),
                      style: const TextStyle(fontSize: 20.0),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 180.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Opções de Pagamento',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        CheckboxListTile(
                          title: const Text('Pix'),
                          activeColor: Colors.green,
                          checkColor: Colors.white,
                          value: isPix,
                          onChanged: (newValue) {
                            setState(() {
                              isPix = newValue ?? false;
                              if (isPix) {
                                isDinDin = false;
                              }
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: const Text('DinDin'),
                          activeColor: Colors.green,
                          checkColor: Colors.white,
                          value: isDinDin,
                          onChanged: (newValue) {
                            setState(() {
                              isDinDin = newValue ?? false;
                              if (isDinDin) {
                                isPix = false;
                              }
                            });
                          },
                        ),
                        // const Text(
                        //   'Preço Total:',
                        //   style: TextStyle(fontSize: 20.0),
                        // ),
                        // Text(
                        //   AppData.formatCurrency(total),
                        //   style: const TextStyle(fontSize: 20.0),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  void selectPaymentMethod(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecionar forma de pagamento'),
          content: const Text('Selecione um método de pagamento.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
