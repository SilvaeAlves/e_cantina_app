// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:e_cantina_app/models/product_model.dart';

class OrderModel {
  int id;
  int idUser;
  int idEstablishment;
  List<ProductModel> products;

  OrderModel({
    this.id = 0,
    required this.products,
    this.idUser = 0,
    this.idEstablishment = 0,
  });

  double get total =>
      products.fold(0, (total, current) => total + current.price);

  OrderModel copyWith({
    List<ProductModel>? products,
  }) {
    return OrderModel(
      id: id,
      idUser: idUser,
      idEstablishment: idEstablishment,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idUser': idUser,
      'idEstablishment': idEstablishment,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] as int,
      idUser: map['idUser'] as int,
      idEstablishment: map['idEstablishment'] as int,
      products: List<ProductModel>.from(
        (map['products'] as List<int>).map<ProductModel>(
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
    return 'OrderModel(id: $id, idUser: $idUser, idEstablishment: $idEstablishment, products: $products)';
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
    CollectionReference orders = firestore.collection('orders');

    try {
      await orders.add(order.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<OrderModel>> getOrdersByIdStablishment(int id) async {
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

  Future<bool> deleteOrder(int id) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference orders = firestore.collection('orders');

    try {
      await orders.doc(id.toString()).delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateOrder(OrderModel order) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference orders = firestore.collection('orders');

    try {
      await orders.doc(order.id.toString()).update(order.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
