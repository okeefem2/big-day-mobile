import 'package:big_day_mobile/models/announcement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementService {
  final _announcementsRef = Firestore.instance.collection('announcements');

  Stream<List<Announcement>> getAnnouncements() {
    return _announcementsRef
        // .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((docSnapshot) => Announcement.fromSnapshot(docSnapshot))
          .toList();
    });
  }

  Stream<Announcement> getById(String id) {
    return _announcementsRef.document(id).snapshots().map((docSnapshot) {
      return docSnapshot.exists
          ? Announcement.fromSnapshot(docSnapshot)
          : Announcement(
              id: null,
              subject: '',
              body: '',
              created: null,
              attendeeLevel: '');
    });
  }

  Future<void> saveAnnouncement(Announcement announcement) {
    if (announcement.id == null) {
      return _announcementsRef.add(announcement.toJson());
    } else {
      return _announcementsRef
          .document(announcement.id)
          .updateData(announcement.toJson());
    }
  }
}
