import 'package:big_day_mobile/models/announcement.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnnouncementViewPage extends StatelessWidget {
  final Announcement announcement;
  final dateFormatter = DateFormat('MMMEd');

  AnnouncementViewPage(this.announcement);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(announcement.subject),
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              announcement.created != null
                  ? Text('Sent ${dateFormatter.format(announcement.created)}',
                      style: TextStyle(fontSize: 20.0))
                  : Text('No Date'),
              Text(announcement.body, style: TextStyle(fontSize: 14.0))
            ],
          ),
        )));
  }
}
