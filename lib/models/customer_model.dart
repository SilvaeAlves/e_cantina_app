// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:e_cantina_app/models/order_model.dart';

class CustomerModel {
  final int id;
  final String email;
  final String password;
  final String name;
  final List<OrderModel> orders;
  CustomerModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.orders,
  });

  CustomerModel copyWith({
    int? id,
    String? email,
    String? password,
    String? name,
    List<OrderModel>? orders,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      orders: orders ?? this.orders,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'orders': orders.map((x) => x.toMap()).toList(),
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'] as int,
      email: map['email'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
      orders: List<OrderModel>.from(
        (map['orders'] as List<int>).map<OrderModel>(
          (x) => OrderModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomerModel(id: $id, email: $email, password: $password, name: $name, orders: $orders)';
  }

  @override
  bool operator ==(covariant CustomerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.password == password &&
        other.name == name &&
        listEquals(other.orders, orders);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        password.hashCode ^
        name.hashCode ^
        orders.hashCode;
  }
}
