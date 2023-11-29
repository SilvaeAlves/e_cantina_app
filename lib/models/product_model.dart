// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:e_cantina_app/app_data/app_data.dart';

class ProductModel {
  int id;
  String name;
  String description;
  String image;
  double price;
  int quantity;
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.quantity,
  });

  ProductModel copyWith({
    String? name,
    String? description,
    String? image,
    double? price,
    int? quantity,
  }) {
    return ProductModel(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }

  static priceTotal(ProductModel product) {
    return AppData.formatCurrency(product.price * product.quantity);
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      price: map['price'] as double,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(name: $name, description: $description, image: $image, price: $price, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.image == image &&
        other.price == price &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        price.hashCode ^
        quantity.hashCode;
  }
}
