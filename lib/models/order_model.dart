// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:e_cantina_app/models/product_model.dart';

class OrderModel {
  List<ProductModel> products;

  OrderModel({
    required this.products,
  });

  double get total =>
      products.fold(0, (total, current) => total + current.price);

  OrderModel copyWith({
    List<ProductModel>? products,
  }) {
    return OrderModel(
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      products: List<ProductModel>.from(
        (map['products'] as List<int>).map<ProductModel>(
          (x) => ProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OrderModel(products: $products)';

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.products, products);
  }

  @override
  int get hashCode => products.hashCode;
}
