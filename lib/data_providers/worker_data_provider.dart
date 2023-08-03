import 'dart:typed_data';

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

  // static Future<String> uploadPaymentReceipt(
  //     PlatformFile pdfPlatformFile) async {
  //   Uint8List fileBytes = pdfPlatformFile!.bytes!;
  //   String fileName = pdfPlatformFile.name;
  //   String downLoadUrl = '';
  //
  //   // Upload file
  //   await FirebaseStorage.instance
  //       .ref('Receipts/$fileName')
  //       .putData(fileBytes)
  //       .then((value) async {
  //     await value.ref.getDownloadURL().then((value) {
  //       downLoadUrl = value;
  //     });
  //   });
  //
  //   return downLoadUrl;
  // }

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
      await updateOrAddUserCredential(uid, fileUrl, name);
    } catch (e) {
      print(e);
    }
    return fileUrl;
  }

  static updateOrAddUserCredential(String uid, String fileUrl, String name) {}
}
