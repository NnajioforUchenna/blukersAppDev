import 'dart:typed_data';

import 'package:bulkers/models/worker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

class WorkerDataProvider {
  static Future<List<Map<String, dynamic>>> getWorkersByJobID(
      String jobId) async {
    // Create a reference to the Firestore collection
    CollectionReference workers = db.collection('workers');

    // Query the collection: Fetch documents where jobId is in the jobPositionIds field
    QuerySnapshot querySnapshot =
        await workers.where('jobPositionIds', arrayContains: jobId).get();

    // Convert the documents to a list of maps and return
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  static Future<String> uploadImageToFirebaseStorage(
      String uid, Uint8List? image, String extention) async {
    final storageRef = FirebaseStorage.instance.ref();
    Reference? imagesRef =
        storageRef.child("ProfileImages/$uid/profileImage.$extention");
    String imageUrl = '';

    try {
      print(image?.lengthInBytes.toString());
      final uploadTask = await imagesRef.putData(
        image!,
        SettableMetadata(
          contentType: "image/$extention",
        ),
      );
      imageUrl = await uploadTask.ref.getDownloadURL();
      // Set the logoUrl in the database
      await updateOrAddUserPhoto(uid, imageUrl);
      return imageUrl;
    } catch (e) {
      print(e);
      return 'error';
    }
  }

  static Future<void> updateOrAddUserPhoto(String uid, String photoUrl) async {
    // For AppUsers collection with photoUrl
    await db.collection('AppUsers').doc(uid).set({
      'photoUrl': photoUrl,
    }, SetOptions(merge: true));

    // For AppUsers collection with worker map
    await db.collection('AppUsers').doc(uid).set({
      'worker': {
        'profilePhotoUrl': photoUrl,
      },
    }, SetOptions(merge: true));

    // For workers collection
    await db.collection('workers').doc(uid).set({
      'profilePhotoUrl': photoUrl,
    }, SetOptions(merge: true));
  }

  static Future<String> uploadCredentialToFirebaseStorage(
      String uid, Uint8List uint8list, String name) async {
    final storageRef = FirebaseStorage.instance.ref();
    Reference? fileRef = storageRef.child("Credentials/$uid/$name");
    String fileUrl = 'error';

    try {
      print(uint8list.lengthInBytes.toString());
      final uploadTaskSnapshot = await fileRef.putData(uint8list);
      fileUrl = await uploadTaskSnapshot.ref.getDownloadURL();

      // Set the logoUrl in the database
      await updateOrAddUserCredential(uid, fileUrl);
    } catch (e) {
      print(e);
    }
    return fileUrl;
  }

  static Future<void> updateOrAddUserCredential(
      String uid, String fileUrl) async {
    // For AppUsers collection within worker map
    await db.collection('AppUsers').doc(uid).set({
      'worker': {
        'certificationsIds': FieldValue.arrayUnion([fileUrl]),
      },
    }, SetOptions(merge: true));

    // For workers collection
    await db.collection('workers').doc(uid).set({
      'certificationsIds': FieldValue.arrayUnion([fileUrl]),
    }, SetOptions(merge: true));
  }

  static Future<void> updateOrAddUserSkill(String uid, String skillId) async {
    // For AppUsers collection within worker map
    await db.collection('AppUsers').doc(uid).set({
      'worker': {
        'skillIds': FieldValue.arrayUnion([skillId]),
      },
    }, SetOptions(merge: true));

    // For workers collection
    await db.collection('workers').doc(uid).set({
      'skillIds': FieldValue.arrayUnion([skillId]),
    }, SetOptions(merge: true));
  }

  static void createWorkerProfile(Worker worker) {
    db
        .collection('workers')
        .doc(worker.workerId)
        .set(worker.toMap(), SetOptions(merge: true));
  }

  static getWorkerProfile(String uid) async {
    final DocumentReference docRef = db.collection('workers').doc(uid);

    try {
      final DocumentSnapshot doc = await docRef.get();

      if (doc.exists) {
        print('Document data: ${doc.data()}');
      } else {
        print('No such document!');
      }
    } catch (e) {
      print('Error fetching document: $e');
    }
  }

  static Future<List<Worker>> getWorkerLists(
      String uid, String parameter) async {
    // Fetch the workerIds from the 'JobPosts' collection
    DocumentSnapshot jobPostSnapshot =
        await db.collection('JobPosts').doc(uid).get();
    List<String>? workerIds = jobPostSnapshot.get(parameter)?.cast<String>();

    // Check if workerIds are null or empty
    if (workerIds == null || workerIds.isEmpty) {
      return [];
    }

    // Fetch the workers from the 'workers' collection based on the workerIds
    List<Worker> workers = [];
    for (String workerId in workerIds) {
      DocumentSnapshot workerSnapshot =
          await db.collection('workers').doc(workerId).get();

      if (workerSnapshot.exists) {
        Map<String, dynamic> workerData =
            workerSnapshot.data()! as Map<String, dynamic>;
        workers.add(Worker.fromMap(workerData));
      }
    }

    return workers;
  }
}
