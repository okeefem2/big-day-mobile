import 'package:big_day_mobile/models/contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactService {
  final _contactsRef = Firestore.instance.collection('contacts');

  Stream<List<Contact>> getContacts() {
    return _contactsRef
        // .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((docSnapshot) => Contact.fromSnapshot(docSnapshot))
          .toList();
    });
  }

  Stream<Contact> getById(String id) {
    return _contactsRef.document(id).snapshots().map((docSnapshot) {
      return docSnapshot.exists
          ? Contact.fromSnapshot(docSnapshot)
          : Contact(
              id: null,
              name: '',
              phone: '',
              email: '',
              role: null,
            );
    });
  }

  Future<void> saveContact(Contact contact) {
    if (contact.id == null) {
      return _contactsRef.add(contact.toJson());
    } else {
      return _contactsRef.document(contact.id).updateData(contact.toJson());
    }
  }
}
