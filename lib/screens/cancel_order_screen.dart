import 'package:e_cantina_app/app_data/app_data.dart';
import 'package:e_cantina_app/config/app_config.dart';
import 'package:e_cantina_app/models/customer_model.dart';
import 'package:e_cantina_app/models/order_model.dart';

import 'package:e_cantina_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CancelOrderUser extends StatefulWidget {
  const CancelOrderUser({super.key, required this.order});
  final OrderModel order;

  @override
  State<CancelOrderUser> createState() => _CancelOrderUserState();
}

class _CancelOrderUserState extends State<CancelOrderUser> {
  bool isCantinaNPreparou = false;
  bool isAlunoNBuscou = false;
  bool isOutroMotivo = false;

  var total = 0.0;

  late CustomerModel customer;

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
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 150.0,
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
                  if (isAlunoNBuscou == false &&
                      isCantinaNPreparou == false &&
                      isOutroMotivo == false) {
                    selectPaymentMethod(context);
                  } else {
                    widget.order.status = 'Cancelado';
                    widget.order.iscancel = true;
                    OrderModel.updateOrder(widget.order);
                    appData.clearCart();
                    appData.clearQuantity();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                        (route) => false);
                  }
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
          'Cancelar Pedido',
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Motivo do cancelamento:',
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CheckboxListTile(
                            title: const Text('Cantina não preparou a tempo'),
                            value: isCantinaNPreparou,
                            onChanged: (bool? value) {
                              setState(() {
                                widget.order.status = 'Cancelado';
                                widget.order.cancelReason =
                                    'Cantina não preparou a tempo';
                                isCantinaNPreparou = true;
                                isAlunoNBuscou = false;
                                isOutroMotivo = false;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Aluno não buscou o pedido'),
                            value: isAlunoNBuscou,
                            onChanged: (bool? value) {
                              setState(() {
                                widget.order.status = 'Cancelado';
                                widget.order.cancelReason =
                                    'Aluno não buscou o pedido';
                                isCantinaNPreparou = false;
                                isAlunoNBuscou = true;
                                isOutroMotivo = false;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: const Text('Outro motivo(Descreva abaixo)'),
                            value: isOutroMotivo,
                            onChanged: (bool? value) {
                              setState(() {
                                widget.order.status = 'Cancelado';
                                widget.order.cancelReason = 'Outro motivo';
                                isCantinaNPreparou = false;
                                isAlunoNBuscou = false;
                                isOutroMotivo = true;
                              });
                            },
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: null, // Define para null para permitir várias linhas
                keyboardType: TextInputType.multiline,
                minLines: 5,
                onChanged: (value) {
                  widget.order.cancelReason = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Digite seu texto aqui...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      )),
    );
  }

  void selectPaymentMethod(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cancelar Pedido'),
          content: const Text('Selecione um motivo.'),
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
