import 'package:e_cantina_app/app_data/app_data.dart';
import 'package:e_cantina_app/config/app_config.dart';
import 'package:e_cantina_app/models/credicard_model.dart';
import 'package:e_cantina_app/models/order_model.dart';
import 'package:e_cantina_app/screens/product_screens.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CredicardScreen extends StatefulWidget {
  const CredicardScreen({super.key, required this.order});

  final OrderModel order;

  @override
  State<CredicardScreen> createState() => _CredicardScreenState();
}

class _CredicardScreenState extends State<CredicardScreen> {
  var maskFormattercardNumber = MaskTextInputFormatter(
      mask: '#### #### #### ####', filter: {"#": RegExp(r'[0-9]')});
  var maskFormattercardDate =
      MaskTextInputFormatter(mask: '##/##', filter: {"#": RegExp(r'[0-9]')});
  var maskFormattercardCvv =
      MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});
  var maskFormattercardName = MaskTextInputFormatter(
      mask: '################', filter: {"#": RegExp(r'[a-zA-Z]')});

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  AppData appData = AppData();

  CredicardModel credicard = CredicardModel(
    cardNumber: '',
    cardExpirationDate: '',
    cardCVV: '',
    cardHolderName: '',
  );
  @override
  void initState() {
    credicard = CredicardModel(
      cardNumber: '',
      cardExpirationDate: '',
      cardCVV: '',
      cardHolderName: '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cartão de Crédito',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppConfig.backgroundColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Form(
        key: globalKey,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: TextFormField(
                initialValue: credicard.cardNumber,
                inputFormatters: [maskFormattercardNumber],
                decoration: const InputDecoration(
                  hintText: 'Número do cartão',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
                onChanged: (value) {
                  credicard.cardNumber = value;
                },
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    initialValue: credicard.cardExpirationDate,
                    onChanged: (value) {
                      credicard.cardExpirationDate = value;
                    },
                    inputFormatters: [maskFormattercardDate],
                    decoration: const InputDecoration(
                      hintText: 'Data de validade',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextFormField(
                    initialValue: credicard.cardCVV,
                    onChanged: (value) {
                      credicard.cardCVV = value;
                    },
                    inputFormatters: [maskFormattercardCvv],
                    decoration: const InputDecoration(
                      hintText: 'CVV',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: TextFormField(
                initialValue: credicard.cardHolderName,
                onChanged: (value) {
                  credicard.cardHolderName = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Nome do titular',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.redAccent),
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      widget.order.isPago = true;

                      OrderModel.updateOrder(widget.order);
                      appData.clearQuantity();
                      appData.clearCart();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProductsScreen()));
                    }
                  },
                  child: const Text('Efetuar Pagamento')),
            )
          ],
        ),
      )),
    );
  }
}
