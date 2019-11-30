import 'package:big_day_mobile/models/schedule_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleService {
  final _scheduleRef = Firestore.instance.collection('schedule');

  Stream<List<ScheduleItem>> getSchedule() {
    return _scheduleRef
        // .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((docSnapshot) => ScheduleItem.fromSnapshot(docSnapshot))
          .toList();
    });
  }

  Stream<ScheduleItem> getById(String id) {
    return _scheduleRef.document(id).snapshots().map((docSnapshot) {
      return docSnapshot.exists
          ? ScheduleItem.fromSnapshot(docSnapshot)
          : ScheduleItem(
              start: null,
              end: null,
              title: '',
              description: '',
              attendeeLevelRequired: null,
              location: null,
            );
    });
  }

  Future<void> save(ScheduleItem item) {
    if (item.id == null) {
      return _scheduleRef.add(item.toJson());
    } else {
      return _scheduleRef.document(item.id).updateData(item.toJson());
    }
  }

  Future<void> delete(String id) {
    return _scheduleRef.document(id).delete();
  }
}
