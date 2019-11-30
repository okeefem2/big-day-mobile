import 'package:big_day_mobile/models/announcement.dart';
import 'package:big_day_mobile/pages/announcement_form_page.dart';
import 'package:big_day_mobile/pages/announcement_view_page.dart';
import 'package:big_day_mobile/services/announcement_service.dart';
import 'package:big_day_mobile/widgets/shared/app_loading.dart';
import 'package:big_day_mobile/widgets/shared/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:big_day_mobile/widgets/shared/app_drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AnnouncementListPage extends StatelessWidget {
  static const route = '/announcements';
  @override
  Widget build(BuildContext context) {
    final announcementService = Provider.of<AnnouncementService>(context);
    // var user = Provider.of<FirebaseUser>(context, listen: false);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(title: Text('Your Orders')),
        body: StreamProvider<List<Announcement>>.value(
            value: announcementService.getAnnouncements(),
            initialData: null,
            child: new AnnouncementList()),
        floatingActionButton: IconButton(
          color: Colors.green,
          onPressed: () {
            Navigator.pushNamed(context, '/announcement-form');
          },
          icon: Icon(Icons.add),
        ));
  }
}

class AnnouncementList extends StatelessWidget {
  final GlobalKey<ScaffoldState> _announcementsLoading = new GlobalKey();

  final dateFormatter = DateFormat('MMMEd');

  Widget _buildAnnouncementRow(
      Announcement announcement, BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: announcement.created != null
              ? Text(dateFormatter.format(announcement.created))
              : Text('No Date'),
          title: Text(announcement.subject),
          trailing: IconButton(
            icon: Icon(Icons.message),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AnnouncementViewPage(announcement)));
            },
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AnnouncementFormPage.route,
                arguments: announcement.id);
          },
          icon: Icon(Icons.edit),
        ),
        Divider(),
      ],
    );
  }

  Widget _buildListView(List<Announcement> announcements) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _buildAnnouncementRow(announcements[index], context);
      },
      itemCount: announcements.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    var announcements = Provider.of<List<Announcement>>(context);

    // _animationController.forward();
    return AppLoading(builder: (context, loading) {
      return announcements == null
          ? new LoadingIndicator(key: _announcementsLoading)
          : _buildListView(announcements);
    });
  }
}
