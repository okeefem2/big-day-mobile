import 'package:big_day_mobile/services/announcement_service.dart';
import 'package:big_day_mobile/services/contact_service.dart';
import 'package:big_day_mobile/services/gallery_service.dart';
import 'package:big_day_mobile/services/loading_service.dart';
import 'package:big_day_mobile/services/schedule_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'pages/announcement_form_page.dart';
import 'pages/announcement_list_page.dart';
import 'pages/contacts_form_page.dart';
import 'pages/contacts_list_page.dart';
import 'pages/gallery_page.dart';
import 'pages/home_page.dart';
import 'pages/schedule_form_page.dart';
import 'pages/schedule_list_page.dart';
import 'pages/map_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoadingService>.value(
          value: LoadingService(),
        ),
        Provider<AnnouncementService>.value(
          value: AnnouncementService(),
        ),
        Provider<ContactService>.value(
          value: ContactService(),
        ),
        Provider<GalleryService>.value(
          value: GalleryService(),
        ),
        Provider<ScheduleService>.value(
          value: ScheduleService(),
        ),
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Big Day',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.orangeAccent,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
        ),
        initialRoute: '/',
        routes: {
          ScheduleListPage.route: (BuildContext context) => ScheduleListPage(),
          ScheduleItemFormPage.route: (BuildContext context) =>
              ScheduleItemFormPage(),
          ContactsListPage.route: (BuildContext context) => ContactsListPage(),
          ContactForm.route: (BuildContext context) => ContactForm(),
          GalleryPage.route: (BuildContext context) => GalleryPage(),
          '/announcements': (BuildContext context) =>
              AnnouncementListPage(), // Users can view newsletter archive, admin can CRUD newsletters and email them to the contacts list via device
          '/announcement-form': (BuildContext context) =>
              AnnouncementFormPage(),
          MapPage.route: (ctx) => MapPage(),
        },
        home: HomePage(),
        onUnknownRoute: (settings) =>
            MaterialPageRoute(builder: (ctx) => HomePage()),
      ),
    );
  }
}
