import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_user.dart';
import 'data_constants.dart';

class StreamService {
  final String? documentId;

  StreamService(this.documentId);

  Stream<AppUser?> get appUser {
    if (documentId == null) {
      return Stream<AppUser?>.empty();
    }
    return FirebaseFirestore.instance
        .collection(appUserCollections)
        .doc(documentId)
        .snapshots()
        .map((snapshot) =>
            snapshot.exists ? AppUser.fromDocument(snapshot) : null);
  }
}
