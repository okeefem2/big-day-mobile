import 'package:big_day_mobile/models/gallery_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GalleryService {
  final _galleryRef = Firestore.instance.collection('gallery');

  Stream<List<GalleryItem>> getGallery() {
    return _galleryRef
        // .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((docSnapshot) => GalleryItem.fromSnapshot(docSnapshot))
          .toList();
    });
  }
}
