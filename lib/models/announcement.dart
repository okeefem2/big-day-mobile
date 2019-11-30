import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Announcement {
  final String id;
  final String subject;
  final String body;
  final DateTime created;
  final String attendeeLevel;

  const Announcement({
    this.id = '',
    this.created,
    @required this.subject,
    @required this.body,
    @required this.attendeeLevel,
  });

  Announcement.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromJson(snapshot.data, id: snapshot.documentID);

  Announcement.fromJson(Map<String, dynamic> json, {this.id})
      : subject = json['subject'],
        body = json['body'],
        created = json['created'],
        attendeeLevel = json['attendeeLevel'];

  Map<String, dynamic> toJson() => {
        'subject': subject,
        'body': body,
        'created': created,
        'attendeeLevel': attendeeLevel
      };
}
