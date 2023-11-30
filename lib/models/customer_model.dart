// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerModel {
  final int id;
  final String email;
  final String password;
  final String name;
  final String socialName;
  final bool isAdm = false;

  CustomerModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.socialName,
    required bool isAdm,
  });

  CustomerModel copyWith({
    int? id,
    String? email,
    String? password,
    String? name,
    String? socialName,
    bool? isAdm,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      socialName: socialName ?? this.socialName,
      isAdm: isAdm ?? this.isAdm,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'password': password,
      'name': name,
      'socialName': socialName,
      'isAdm': isAdm,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'] as int,
      email: map['email'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
      socialName: map['socialName'] as String,
      isAdm: map['isAdm'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomerModel(id: $id, email: $email, password: $password, name: $name, socialName: $socialName, isAdm: $isAdm)';
  }

  @override
  bool operator ==(covariant CustomerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.password == password &&
        other.name == name &&
        other.socialName == socialName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        password.hashCode ^
        name.hashCode ^
        socialName.hashCode;
  }

  Future<bool> saveCustomer() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore.collection("customers").doc(email).set(toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateCustomer() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection("customers").doc(email).update(toMap());
  }

  Future<void> deleteCustomer() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection("customers").doc(email).delete();
  }

  static Future<CustomerModel> getCustomerByEmailAndPassword(
      String email, String password) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      DocumentSnapshot documentSnapshot =
          await firestore.collection("customers").doc(email).get();
      Map<String, dynamic> data =
          documentSnapshot.data() as Map<String, dynamic>;
      if (data['password'] == password) {
        return CustomerModel.fromMap(data);
      } else {
        return CustomerModel(
            id: 0,
            email: '',
            password: '',
            name: '',
            socialName: '',
            isAdm: false);
      }
    } catch (e) {
      return CustomerModel(
          id: 0,
          email: '',
          password: '',
          name: '',
          socialName: '',
          isAdm: false);
    }
  }

  static int createId() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static saveCustomerUserLocal(CustomerModel customer) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('customer', json.encode(customer.toMap()));
  }

  static Future<CustomerModel> getCustomerUserLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? customer = prefs.getString('customer');
    if (customer != null) {
      return CustomerModel.fromMap(json.decode(customer));
    } else {
      return CustomerModel(
          id: 0,
          email: '',
          password: '',
          name: '',
          socialName: '',
          isAdm: false);
    }
  }
}
