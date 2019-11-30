import 'package:big_day_mobile/enums/attendee_level.dart';
import 'package:big_day_mobile/models/place_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScheduleItem {
  final String id;
  final DateTime start;
  final DateTime end;
  final String title;
  final String description;
  final AttendeeLevel attendeeLevelRequired;
  final PlaceLocation location;

  const ScheduleItem({
    this.id = '',
    this.start,
    this.end,
    @required this.title,
    @required this.description,
    @required this.attendeeLevelRequired,
    @required this.location,
  });

  ScheduleItem update({
    String id,
    DateTime start,
    DateTime end,
    String title,
    String description,
    AttendeeLevel attendeeLevelRequired,
    PlaceLocation location,
  }) {
    return ScheduleItem(
      id: id == null ? this.id : id,
      start: start == null ? this.start : start,
      end: end == null ? this.end : end,
      title: title == null ? this.title : title,
      description: description == null ? this.description : description,
      attendeeLevelRequired: attendeeLevelRequired == null
          ? this.attendeeLevelRequired
          : attendeeLevelRequired,
      location: location == null ? this.location : location,
    );
  }

  ScheduleItem.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromJson(snapshot.data, id: snapshot.documentID);

  ScheduleItem.fromJson(Map<String, dynamic> json, {this.id})
      : start = DateTime.parse(json['start']),
        end = DateTime.parse(json['end']),
        title = json['title'],
        description = json['description'],
        attendeeLevelRequired = json['attendeeLevelRequired'],
        location = PlaceLocation.fromJson(json['end']);

  Map<String, dynamic> toJson() => {
        'start': start,
        'end': end,
        'title': title,
        'description': description,
        'attendeeLevelRequired': attendeeLevelRequired,
        'location': location.toJson(),
      };
}
