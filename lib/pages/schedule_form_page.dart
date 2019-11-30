import 'package:big_day_mobile/enums/attendee_level.dart';
import 'package:big_day_mobile/models/place_location.dart';
import 'package:big_day_mobile/models/schedule_item.dart';
import 'package:big_day_mobile/services/schedule_service.dart';
import 'package:big_day_mobile/widgets/shared/location_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScheduleItemFormPage extends StatelessWidget {
  static const route = '/schedule-form';
  @override
  Widget build(BuildContext context) {
    final scheduleService = Provider.of<ScheduleService>(context);
    final id = ModalRoute.of(context).settings.arguments as String;
    return StreamProvider<ScheduleItem>.value(
        value: scheduleService.getById(id),
        initialData: null,
        child: ScheduleItemForm());
  }
}

class ScheduleItemForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScheduleItemFormState();
  }
}

class _ScheduleItemFormState extends State<ScheduleItemForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final _startFocusNode = FocusNode();
  // final _endFocusNode = FocusNode();
  // final _titleFocusNode = FocusNode();
  // final _descriptionFocusNode = FocusNode();
  // final _attendeeLevelRequiredFocusNode = FocusNode();

  ScheduleItem _scheduleItem;

  var _initValues = {
    'start': null,
    'end': null,
    'title': null,
    'description': null,
    'attendeeLevelRequired': null,
    'location': null,
  };

  @override
  void initState() {
    super.initState();
  }

  void _initScheduleItem(ScheduleItem scheduleItem) {
    if (scheduleItem != null) {
      _scheduleItem = scheduleItem;
      setState(() {
        _initValues = _scheduleItem.toJson();
      });
    }
  }

  void _setLocation({double lat, double long}) {
    _scheduleItem.update(
        location: new PlaceLocation(latitude: lat, longitude: long));
  }

  void _save() async {
    var validationSuccess = _formKey.currentState.validate();
    if (validationSuccess) {
      _formKey.currentState.save();

      Provider.of<ScheduleService>(context, listen: false)
          .save(_scheduleItem)
          .catchError((err) {
        // Pass this to then if error is thrown
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('An Error Occurred'),
                  content: Text(err.toString()),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Okay'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      }).then((_) {
        Navigator.of(context).pop();
      });
      Navigator.pop(context);
    }
  }

  Widget _buildForm(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final width = deviceWidth > 600.0 ? 400.0 : deviceWidth * 0.9;
    final padding = deviceWidth - width;

    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
            FocusNode()), // Form will override and handle it's own tappage
        child: Container(
            margin: EdgeInsets.all(10.0),
            child: Form(
                key: _formKey,
                child: ListView(
                  // ListView items always take the full available space on the screen
                  padding: EdgeInsets.symmetric(horizontal: padding / 2),
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Event Start',
                          contentPadding: EdgeInsets.all(
                              10.0) // Puts padding inside of the textField
                          ),
                      keyboardType: TextInputType.datetime,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Start date is required';
                        }
                        return null;
                      },
                      initialValue: _initValues['start'],
                      maxLines: 1,
                      onSaved: (String change) =>
                          _scheduleItem.update(start: DateTime.parse(change)),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Event End',
                          contentPadding: EdgeInsets.all(
                              10.0) // Puts padding inside of the textField
                          ),
                      keyboardType: TextInputType.datetime,
                      validator: (String value) {
                        // TODO check if before start date
                        if (value.isEmpty) {
                          return 'End date is required';
                        }
                        return null;
                      },
                      initialValue: _initValues['end'],
                      maxLines: 1,
                      onSaved: (String change) =>
                          _scheduleItem.update(end: DateTime.parse(change)),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Title',
                          contentPadding: EdgeInsets.all(
                              10.0) // Puts padding inside of the textField
                          ),
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Title is required';
                        }
                        return null;
                      },
                      initialValue: _initValues['title'],
                      maxLines: 1,
                      onSaved: (String change) =>
                          _scheduleItem.update(title: change),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Description',
                          contentPadding: EdgeInsets.all(
                              10.0) // Puts padding inside of the textField
                          ),
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Description is required';
                        }
                        return null;
                      },
                      initialValue: _initValues['description'],
                      maxLines: 1,
                      onSaved: (String change) =>
                          _scheduleItem.update(title: change),
                    ),
                    DropdownButtonFormField<AttendeeLevel>(
                      value: _initValues['attendeeLevelRequired'],
                      decoration: InputDecoration(
                          labelText: 'Attendee Level',
                          contentPadding: EdgeInsets.all(
                              10.0) // Puts padding inside of the textField
                          ),
                      validator: (AttendeeLevel value) {
                        if (value == null) {
                          return 'Attendee level is required';
                        }
                        return null;
                      },
                      items: attendeeLevelDropdown,
                      onChanged: (AttendeeLevel change) {
                        setState(() {
                          _initValues['attendeeLevelRequired'] = change;
                        });
                      },
                      onSaved: (AttendeeLevel change) =>
                          _scheduleItem.update(attendeeLevelRequired: change),
                    ),
                    LocationInput(
                        onSelectLocation: _setLocation,
                        initialLocation: _initValues['location']),
                    RaisedButton(
                      onPressed: () => _save(),
                      child: Text('Save'),
                    )
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    final scheduleItem = Provider.of<ScheduleItem>(context);
    _initScheduleItem(scheduleItem);
    return Scaffold(
        appBar: AppBar(
          title: scheduleItem != null
              ? Text('Edit Schedule Item')
              : Text('Add Schedule Item'),
        ),
        body: _buildForm(context));
  }
}
