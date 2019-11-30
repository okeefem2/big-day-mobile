import 'package:big_day_mobile/services/schedule_service.dart';
import 'package:flutter/material.dart';
import 'package:big_day_mobile/models/schedule_item.dart';
import 'package:big_day_mobile/widgets/shared/app_drawer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'schedule_form_page.dart';

class ScheduleListPage extends StatefulWidget {
  static const route = '/schedule';

  @override
  State<StatefulWidget> createState() {
    return _ScheduleListPageState();
  }
}

class _ScheduleListPageState extends State<ScheduleListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKeySchedule = new GlobalKey();
  // final GlobalKey<ScaffoldState> _scheduleLoading = new GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scheduleService = Provider.of<ScheduleService>(context);
    return Scaffold(
        key: _scaffoldKeySchedule,
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Schedule'),
        ),
        body: StreamProvider<List<ScheduleItem>>.value(
          value: scheduleService.getSchedule(),
          initialData: [],
          child: new ScheduleList(),
        ));
  }
}

class ScheduleList extends StatelessWidget {
  final dateFormatter = DateFormat('MMMEd');
  final timeFormatter = DateFormat('Hm');
  Widget _buildScheduleRow(ScheduleItem scheduleItem, BuildContext context) {
    return ExpansionTile(
      title: Row(
        children: <Widget>[
          scheduleItem.start != null
              ? Text(dateFormatter.format(scheduleItem.start))
              : Text('No Date Set'),
          SizedBox(
            width: 10.0,
          ),
          Text(
            scheduleItem.title,
            style: TextStyle(color: Colors.black.withOpacity(0.65)),
          )
        ],
      ),
      children: <Widget>[
        ListTile(
          title: Text('Start Time'),
          trailing: scheduleItem.start != null
              ? Text(timeFormatter.format(scheduleItem.start))
              : Text('No Start Time Set'),
        ),
        ListTile(
          title: Text('End Time'),
          trailing: scheduleItem.end != null
              ? Text(timeFormatter.format(scheduleItem.end))
              : Text('No End Time Set'),
        ),
        ListTile(
          title: Text('Location'),
          trailing: IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              // TODO show map
            },
          ),
        ),
        Divider(),
        ListTile(
          title: Text(scheduleItem.description),
        ),
        IconButton(
          onPressed: () =>
              Navigator.pushNamed(context, ScheduleItemFormPage.route),
          icon: Icon(Icons.edit),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var scheduleItems = Provider.of<List<ScheduleItem>>(context);
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _buildScheduleRow(scheduleItems[index], context);
      },
      itemCount: scheduleItems.length,
    );
  }
}
