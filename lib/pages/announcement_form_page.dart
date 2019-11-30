import 'package:big_day_mobile/services/announcement_service.dart';
import 'package:flutter/material.dart';
import 'package:big_day_mobile/models/announcement.dart';
import 'package:provider/provider.dart';

class AnnouncementFormPage extends StatelessWidget {
  static const route = '/announcement-form';
  @override
  Widget build(BuildContext context) {
    final announcementsService = Provider.of<AnnouncementService>(context);
    final announcementId = ModalRoute.of(context).settings.arguments as String;
    return StreamProvider<Announcement>.value(
        value: announcementsService.getById(announcementId),
        initialData: null,
        child: AnnouncementForm());
  }
}

class AnnouncementForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnnouncementFormState();
  }
}

class _AnnouncementFormState extends State<AnnouncementForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {
    'subject': null,
    'body': null,
    'attendeeLevel': null,
  };

  @override
  void initState() {
    super.initState();
  }

  Widget _buildForm(Announcement announcement, BuildContext context) {
    if (_formData['attendeeLevel'] == null && announcement != null) {
      _formData['attendeeLevel'] = announcement.attendeeLevel;
    }
    final double deviceWidth = MediaQuery.of(context).size.width;
    final width = deviceWidth > 600.0 ? 400.0 : deviceWidth * 0.9;
    final padding = deviceWidth - width;
    List<DropdownMenuItem<String>> attendeeLevels = [
      DropdownMenuItem(
        value: 'Betrothed',
        child: Text('Betrothed Only'),
      ),
      DropdownMenuItem(
        value: 'Wedding Party',
        child: Text('Weddding Party Only'),
      ),
      DropdownMenuItem(
        value: 'All Guests',
        child: Text('All Guests'),
      )
    ];
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
                          labelText: 'Subject',
                          contentPadding: EdgeInsets.all(
                              10.0) // Puts padding inside of the textField
                          ),
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Subject is required';
                        }
                        return null;
                      },
                      initialValue:
                          announcement != null ? announcement.subject : '',
                      maxLines: 1,
                      onSaved: (String change) => _formData['subject'] = change,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Body',
                          contentPadding: EdgeInsets.all(
                              10.0) // Puts padding inside of the textField
                          ),
                      keyboardType: TextInputType.number,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Body is required';
                        }
                        return null;
                      },
                      initialValue:
                          announcement != null ? announcement.body : '',
                      maxLines: 5,
                      onSaved: (String change) => _formData['body'] = change,
                    ),
                    DropdownButtonFormField<String>(
                      value: _formData['attendeeLevel'],
                      decoration: InputDecoration(
                          labelText: 'Attendee Level',
                          contentPadding: EdgeInsets.all(
                              10.0) // Puts padding inside of the textField
                          ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Attendee level is required';
                        }
                        return null;
                      },
                      items: attendeeLevels,
                      onChanged: (String change) {
                        setState(() {
                          _formData['attendeeLevel'] = change;
                        });
                      },
                      onSaved: (String change) =>
                          _formData['attendeeLevel'] = change,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        var validationSuccess =
                            _formKey.currentState.validate();
                        if (validationSuccess) {
                          _formKey.currentState.save();
                          _formData['id'] =
                              announcement != null ? announcement.id : null;
                          _formData['created'] = announcement != null
                              ? announcement.created
                              : DateTime.now();
                          await Provider.of<AnnouncementService>(context,
                                  listen: false)
                              .saveAnnouncement(announcement);
                          // TODO error handling
                          Navigator.pop(context);
                        }
                      },
                      child: Text('Save'),
                    )
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    var editAnnouncement = Provider.of<Announcement>(context);
    return Scaffold(
        appBar: AppBar(
          title: editAnnouncement != null
              ? Text('Edit Announcement')
              : Text('Add Announcement'),
        ),
        body: _buildForm(editAnnouncement, context));
  }
}
