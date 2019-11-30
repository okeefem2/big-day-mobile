import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GalleryItem {
  final String id;
  final String description;
  final DateTime created;
  final String photoUrl;

  GalleryItem({
    this.id = '',
    @required this.description,
    @required this.created,
    @required this.photoUrl,
  });

  GalleryItem.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromJson(snapshot.data, id: snapshot.documentID);

  GalleryItem.fromJson(Map<String, dynamic> json, {this.id})
      : description = json['description'],
        created = json['created'],
        photoUrl = json['photoUrl'];

  Map<String, dynamic> toJson() =>
      {'description': description, 'created': created, 'photoUrl': photoUrl};
}
