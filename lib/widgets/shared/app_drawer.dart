import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
    Widget _buildDrawer(BuildContext context) {
    return Drawer(
        child: Column(children: <Widget>[
          SizedBox(height: 50.0,),
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Home'),
        onTap: () {
          Navigator.pushReplacementNamed(context, '/');
        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.contacts),
        title: Text('Contacts'),
        onTap: () {
          Navigator.pushReplacementNamed(context, '/contacts');
        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.schedule),
        title: Text('Schedule'),
        onTap: () {
          Navigator.pushReplacementNamed(context, '/schedule');
        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.announcement),
        title: Text('Announcements'), // TODO add a trailing with number of announcements
        onTap: () {
          Navigator.pushReplacementNamed(context, '/announcements');
        },
      ),
      Divider(),
      ListTile(
        leading: Icon(Icons.photo),
        title: Text('Gallery'),
        onTap: () {
          Navigator.pushReplacementNamed(context, '/gallery');
        },
      ),
      Divider(),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return _buildDrawer(context);
  } 
}