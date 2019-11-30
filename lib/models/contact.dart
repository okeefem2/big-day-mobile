import 'package:big_day_mobile/enums/role.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Contact {
  final String id;
  final String name;
  final String phone;
  final String email;
  final Role role;

  const Contact({
    this.id = '',
    @required this.name,
    @required this.phone,
    @required this.email,
    @required this.role,
  });

  Contact.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromJson(snapshot.data, id: snapshot.documentID);

  Contact.fromJson(Map<String, dynamic> json, {this.id})
      : name = json['name'],
        phone = json['phone'],
        email = json['email'],
        role = json['role'];

  Map<String, dynamic> toJson() => {
      'name': name,
      'phone': phone,
      'email': email,
      'role': role
    };
}
