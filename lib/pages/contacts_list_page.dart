import 'package:big_day_mobile/pages/contacts_form_page.dart';
import 'package:big_day_mobile/services/contact_service.dart';
import 'package:big_day_mobile/widgets/shared/app_loading.dart';
import 'package:big_day_mobile/widgets/shared/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:big_day_mobile/models/contact.dart';
import 'package:big_day_mobile/widgets/shared/app_drawer.dart';
import 'package:provider/provider.dart';

class ContactsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContactsListState();
  }
}

class _ContactsListState extends State<ContactsList> {
  final GlobalKey<ScaffoldState> _contactsLoading = new GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  Widget _buildContactRow(Contact contact) {
    return ExpansionTile(
      title: Row(
        children: <Widget>[
          Text(contact.name),
          SizedBox(
            width: 10.0,
          ),
          Text(
            contact.role.toString(),
            style: TextStyle(color: Colors.black.withOpacity(0.45)),
          )
        ],
      ),
      children: <Widget>[
        ListTile(
          title: Text(contact.phone),
          trailing: IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {},
          ),
        ),
        Divider(),
        ListTile(
          title: Text(contact.email),
          trailing: IconButton(
            icon: Icon(Icons.email),
            onPressed: () {},
          ),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamed(ContactForm.route, arguments: contact.id);
          },
          icon: Icon(Icons.edit),
        )
      ],
    );
  }

  Widget _buildListView(List<Contact> contacts) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _buildContactRow(contacts[index]);
      },
      itemCount: contacts.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    var contacts = Provider.of<List<Contact>>(context);

    return AppLoading(builder: (context, loading) {
      return loading
          ? new LoadingIndicator(key: _contactsLoading)
          : _buildListView(contacts);
    });
  }
}

class ContactsListPage extends StatelessWidget {
  static const route = '/contacts';

  final GlobalKey<ScaffoldState> _scaffoldKeyContacts = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    final contactService = Provider.of<ContactService>(context);

    return Scaffold(
      key: _scaffoldKeyContacts,
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: StreamProvider<List<Contact>>.value(
          value: contactService.getContacts(),
          initialData: null,
          child: new ContactsList()),
      floatingActionButton: IconButton(
        color: Colors.green,
        onPressed: () {
          Navigator.pushNamed(context, ContactForm.route);
        },
        icon: Icon(Icons.add),
      ),
    );
  }
}
