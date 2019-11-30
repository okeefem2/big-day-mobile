import 'package:big_day_mobile/services/contact_service.dart';
import 'package:flutter/material.dart';
import 'package:big_day_mobile/models/contact.dart';
import 'package:provider/provider.dart';

class ContactFormPage extends StatelessWidget {
  static const route = '/contacts-form';
  @override
  Widget build(BuildContext context) {
    final contactService = Provider.of<ContactService>(context);
    final contactId = ModalRoute.of(context).settings.arguments as String;
    return StreamProvider<Contact>.value(
        value: contactService.getById(contactId),
        initialData: null,
        child: ContactForm());
  }
}

class ContactForm extends StatefulWidget {
  static const route = '/contacts-form';

  @override
  State<StatefulWidget> createState() {
    return _ContactFormState();
  }
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {
    'name': null,
    'phone': null,
    'email': null,
    'role': null,
  };

  @override
  void initState() {
    super.initState();
  }

  Widget _buildForm(Contact contact, BuildContext context) {
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
                          labelText: 'Name',
                          contentPadding: EdgeInsets.all(
                              10.0) // Puts padding inside of the textField
                          ),
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Name is required';
                        }
                        return null;
                      },
                      initialValue: contact != null ? contact.name : '',
                      maxLines: 1,
                      onSaved: (String change) => _formData['name'] = change,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Phone',
                          contentPadding: EdgeInsets.all(
                              10.0) // Puts padding inside of the textField
                          ),
                      keyboardType: TextInputType.number,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Phone is required';
                        }
                        return null;
                      },
                      initialValue: contact != null ? contact.phone : '',
                      maxLines: 1,
                      onSaved: (String change) => _formData['phone'] = change,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Email',
                          contentPadding: EdgeInsets.all(
                              10.0) // Puts padding inside of the textField
                          ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Email is required';
                        }
                        if (!RegExp(
                                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                            .hasMatch(value)) {
                          return 'Email is invalid';
                        }
                        return null;
                      },
                      initialValue: contact != null ? contact.email : '',
                      maxLines: 1,
                      onSaved: (String change) => _formData['email'] = change,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Role',
                          contentPadding: EdgeInsets.all(
                              10.0) // Puts padding inside of the textField
                          ),
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Role is required';
                        }
                        return null;
                      },
                      initialValue: contact != null ? contact.role : '',
                      maxLines: 1,
                      onSaved: (String change) => _formData['role'] = change,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        var validationSuccess =
                            _formKey.currentState.validate();
                        if (validationSuccess) {
                          _formKey.currentState.save();
                          _formData['id'] = contact != null ? contact.id : null;
                          await Provider.of<ContactService>(context,
                                  listen: false)
                              .saveContact(contact);
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
    var editContact = Provider.of<Contact>(context);
    return Scaffold(
        appBar: AppBar(
          title:
              editContact != null ? Text('Edit Contact') : Text('Add Contact'),
        ),
        body: _buildForm(editContact, context));
  }
}
