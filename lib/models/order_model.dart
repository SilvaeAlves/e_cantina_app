// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:e_cantina_app/models/product_model.dart';

class OrderModel {
  int id;
  int idUser;
  String nameUser;
  int numberOrder;
  bool isPago;
  int idEstablishment;
  double total = 0.0;
  String status;
  String paymentMethod;
  bool iscancel;
  String cancelReason = '';
  List<ProductModel> products;

  OrderModel({
    this.id = 0,
    required this.products,
    this.idUser = 0,
    this.nameUser = '',
    this.numberOrder = 0,
    this.isPago = false,
    this.idEstablishment = 0,
    this.total = 0.0,
    this.status = 'Pendente',
    this.paymentMethod = 'Pix',
    this.iscancel = false,
    this.cancelReason = '',
  });

  OrderModel copyWith({
    List<ProductModel>? products,
  }) {
    return OrderModel(
        id: id,
        idUser: idUser,
        nameUser: nameUser,
        numberOrder: numberOrder,
        isPago: isPago,
        idEstablishment: idEstablishment,
        products: products ?? this.products,
        total: total,
        status: status,
        paymentMethod: paymentMethod,
        iscancel: iscancel,
        cancelReason: cancelReason);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idUser': idUser,
      'nameUser': nameUser,
      'numberOrder': numberOrder,
      'isPago': isPago,
      'idEstablishment': idEstablishment,
      'products': products.map((x) => x.toMap()).toList(),
      'total': total,
      'status': status,
      'paymentMethod': paymentMethod,
      'iscancel': iscancel,
      'cancelReason': cancelReason,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as int,
      idUser: map['idUser'] as int,
      nameUser: map['nameUser'] as String,
      numberOrder: map['numberOrder'] as int,
      isPago: map['isPago'] as bool,
      idEstablishment: map['idEstablishment'] as int,
      total: map['total'] as double,
      status: map['status'] as String,
      paymentMethod: map['paymentMethod'] as String,
      iscancel: map['iscancel'] as bool,
      cancelReason: map['cancelReason'] as String,
      products: List<ProductModel>.from(
        (map['products'] as List<dynamic>).map<ProductModel>(
          (x) => ProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) {
    return OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  @override
  String toString() {
    return 'OrderModel(id: $id, idUser: $idUser, nameUser: $nameUser, isPago: $isPago, idEstablishment: $idEstablishment, products: $products, total: $total, status: $status, paymentMethod: $paymentMethod)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.products, products);
  }

  @override
  int get hashCode => products.hashCode;

  Future<void> addProduct(ProductModel product) async {
    products.add(product);
  }

  static Future<bool> saveOrder(OrderModel order) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    for (var element in order.products) {
      order.total += element.price * element.quantity;
    }

    try {
      await firestore
          .collection('orders')
          .doc(order.id.toString())
          .set(order.toMap());

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<OrderModel>> getOrdersByIdStablishment(int id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference orders = firestore.collection('orders');

    try {
      QuerySnapshot querySnapshot =
          await orders.where('idEstablishment', isEqualTo: id).get();
      List<OrderModel> ordersList = querySnapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      return ordersList;
    } catch (e) {
      return [];
    }
  }

  static Future<List<OrderModel>> getOrdersByIdUser(int idUser) async {
    CollectionReference igrejasCollection =
        FirebaseFirestore.instance.collection('orders');
    QuerySnapshot querySnapshot = await igrejasCollection.get();

    List<OrderModel> orderlist = [];
    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
      OrderModel order = OrderModel.fromMap(data);
      if (order.idUser == idUser) {
        orderlist.add(order);
      }
    }
    return orderlist;
  }

  static Future<OrderModel?> getOrderById(int id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference orders = firestore.collection('orders');

    try {
      DocumentSnapshot documentSnapshot = await orders.doc(id.toString()).get();
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      return OrderModel.fromMap(data);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> deleteOrder(int id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference orders = firestore.collection('orders');

    try {
      await orders.doc(id.toString()).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateOrder(OrderModel order) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore
          .collection('orders')
          .doc(order.id.toString())
          .set(order.toMap());

      return true;
    } catch (e) {
      return false;
    }
  }
}
