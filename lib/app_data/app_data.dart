import 'package:e_cantina_app/models/order_model.dart';
import 'package:e_cantina_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppData extends ChangeNotifier {
  List<ProductModel> products = [
    ProductModel(
      id: 1,
      name: 'Salgado',
      description: 'Salgado assado recheado com frango e queijo',
      image: 'assets/images/salgado.jpeg',
      price: 3.50,
      quantity: 0,
    ),
    ProductModel(
      id: 2,
      name: 'Refrigerante',
      description: 'Lata de refrigerante de cola',
      image: 'assets/images/refrigerante.jpeg',
      price: 4.00,
      quantity: 0,
    ),
    ProductModel(
      id: 3,
      name: 'Sanduíche Natural',
      description: 'Sanduíche saudável com vegetais frescos',
      image: 'assets/images/sanduiche.jpeg',
      price: 5.50,
      quantity: 0,
    ),
    ProductModel(
      id: 4,
      name: 'Café',
      description: 'Xícara de café fresco',
      image: 'assets/images/cafe.jpeg',
      price: 2.50,
      quantity: 0,
    ),
    ProductModel(
      id: 5,
      name: 'Bolo de Chocolate',
      description: 'Fatia de bolo de chocolate caseiro',
      image: 'assets/images/bolo.jpeg',
      price: 3.00,
      quantity: 0,
    ),
    ProductModel(
      id: 6,
      name: 'Água Mineral',
      description: 'Garrafa de água mineral sem gás',
      image: 'assets/images/agua.jpeg',
      price: 2.00,
      quantity: 0,
    ),
    ProductModel(
      id: 7,
      name: 'Coxinha',
      description: 'Coxinha frita recheada com frango',
      image: 'assets/images/coxinha.jpeg',
      price: 3.20,
      quantity: 0,
    ),
    ProductModel(
      id: 8,
      name: 'Suco Natural',
      description: 'Copo de suco de frutas frescas',
      image: 'assets/images/suco.jpeg',
      price: 4.50,
      quantity: 0,
    ),
    ProductModel(
      id: 9,
      name: 'Batata Frita',
      description: 'Porção de batata frita crocante',
      image: 'assets/images/batata.jpeg',
      price: 3.80,
      quantity: 0,
    ),
    ProductModel(
      id: 10,
      name: 'Pão de Queijo',
      description: 'Porção de pães de queijo quentinhos',
      image: 'assets/images/pao_de_queijo.jpeg',
      price: 2.80,
      quantity: 0,
    ),
  ];

  List<ProductModel> cart = [];

  void addToCart(ProductModel product) {
    product.quantity++;
    notifyListeners();
    for (var item in cart) {
      if (item.id == product.id) {
        return;
      }
    }
    cart.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    product.quantity--;
    if (product.quantity == 0) {
      cart.remove(product);
    }

    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }

  double get cartTotal =>
      cart.fold(0, (total, current) => total + current.price);

  List<OrderModel> orders = [];

  void addOrder(OrderModel order) {
    orders.add(order);
    notifyListeners();
  }

  void clearQuantity() {
    for (var product in products) {
      product.quantity = 0;
    }
    notifyListeners();
  }

  void clearOrders() {
    orders.clear();
    notifyListeners();
  }

  double get ordersTotal =>
      orders.fold(0, (total, current) => total + current.total);

  void removeOrder(OrderModel order) {
    orders.remove(order);
    notifyListeners();
  }

  void removeProductFromOrder(OrderModel order, ProductModel product) {
    order.products.remove(product);
    notifyListeners();
  }

  void addProductToOrder(OrderModel order, ProductModel product) {
    order.products.add(product);
    notifyListeners();
  }

  static String formatCurrency(double value) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return currencyFormatter.format(value);
  }
}
