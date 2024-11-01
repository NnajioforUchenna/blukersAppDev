import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

import '../models/worker.dart';
import 'data_constants.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

class WorkerDataProvider {
  static Future<List<Map<String, dynamic>>> getWorkersByJobID(
      String jobId) async {
    // Create a reference to the Firestore collection
    CollectionReference workers = db.collection(workersCollections);

    // Query the collection: Fetch documents where jobId is in the jobPositionIds field
    QuerySnapshot querySnapshot =
        await workers.where('jobIds', arrayContains: jobId).get();

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
    await db.collection(appUserCollections).doc(uid).set({
      'photoUrl': photoUrl,
    }, SetOptions(merge: true));

    // For AppUsers collection with worker map
    await db.collection(appUserCollections).doc(uid).set({
      'worker': {
        'profilePhotoUrl': photoUrl,
      },
    }, SetOptions(merge: true));

    // For workers collection
    await db.collection(workersCollections).doc(uid).set({
      'profilePhotoUrl': photoUrl,
    }, SetOptions(merge: true));
  }

  static Future<String> uploadCredentialToFirebaseStorageWeb(
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

  static Future<String> uploadCredentialToFirebaseStorageMobile(
      String uid, File file, String name) async {
    final storageRef = FirebaseStorage.instance.ref();
    Reference fileRef = storageRef.child("Credentials/$uid/$name");
    String fileUrl = 'error';

    try {
      UploadTask uploadTask = fileRef.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      fileUrl = await snapshot.ref.getDownloadURL();
      // Set the URL in the database
      await updateOrAddUserCredential(uid, fileUrl);
    } catch (e) {
      print(e);
    }
    return fileUrl;
  }

  static Future<void> updateOrAddUserCredential(
      String uid, String fileUrl) async {
    // For AppUsers collection within worker map
    await db.collection(appUserCollections).doc(uid).set({
      'worker': {
        'certificationsIds': FieldValue.arrayUnion([fileUrl]),
      },
    }, SetOptions(merge: true));

    // For workers collection
    await db.collection(workersCollections).doc(uid).set({
      'certificationsIds': FieldValue.arrayUnion([fileUrl]),
    }, SetOptions(merge: true));
  }

  static Future<void> updateOrAddUserSkill(String uid, String skillId) async {
    // For AppUsers collection within worker map
    await db.collection(appUserCollections).doc(uid).set({
      'worker': {
        'skillIds': FieldValue.arrayUnion([skillId]),
      },
    }, SetOptions(merge: true));

    // For workers collection
    await db.collection(workersCollections).doc(uid).set({
      'skillIds': FieldValue.arrayUnion([skillId]),
    }, SetOptions(merge: true));
  }

  static void createWorkerProfile(Worker worker) {
    db
        .collection(workersCollections)
        .doc(worker.workerId)
        .set(worker.toMap(), SetOptions(merge: true));
  }

  static getWorkerProfile(String uid) async {
    final DocumentReference docRef = db.collection(workersCollections).doc(uid);

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

    // Fetch the workers from the workersCollections collection based on the workerIds
    List<Worker> workers = [];
    for (String workerId in workerIds) {
      DocumentSnapshot workerSnapshot =
          await db.collection(workersCollections).doc(workerId).get();

      if (workerSnapshot.exists) {
        Map<String, dynamic> workerData =
            workerSnapshot.data()! as Map<String, dynamic>;
        Worker? worker = Worker.fromMap(workerData);
        if (worker != null) {
          workers.add(worker); // Only add if not null
        }
      }
    }

    return workers;
  }

  // static Future<List<Worker>> getWorkers(
  //     String nameRelated, String locationRelated) async {
  //   final CollectionReference workersCollection =
  //       FirebaseFirestore.instance.collection(workersCollections);
  //
  //   // Query for each field separately
  //   var queries = [
  //     workersCollection.where('firstName', isEqualTo: nameRelated),
  //     workersCollection.where('middleName', isEqualTo: nameRelated),
  //     workersCollection.where('lastName', isEqualTo: nameRelated),
  //     workersCollection.where('addresses.street', isEqualTo: locationRelated),
  //     workersCollection.where('addresses.city', isEqualTo: locationRelated),
  //     workersCollection.where('addresses.state', isEqualTo: locationRelated),
  //     workersCollection.where('addresses.country', isEqualTo: locationRelated),
  //   ];
  //
  //   // Execute all queries and combine the results
  //   var allWorkers = <Worker>[];
  //   for (var query in queries) {
  //     final snapshot = await query.get();
  //     final workers = snapshot.docs.map((doc) {
  //       return Worker.fromMap(doc.data() as Map<String, dynamic>);
  //     }).toList();
  //     allWorkers.addAll(workers);
  //   }
  //
  //   // Optionally, remove duplicates
  //   var uniqueWorkers = <Worker>{};
  //   uniqueWorkers.addAll(allWorkers);
  //   allWorkers = uniqueWorkers.toList();
  //
  //   return allWorkers;
  // }

  static Future<List<Worker>> getWorkers(
      String nameRelated, String locationRelated) async {
    final response = await http.post(
      Uri.parse('$baseUrlAppEngineFunctions/searchWorkers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nameRelated': nameRelated,
        'locationRelated': locationRelated,
      }),
    );

    if (response.statusCode == 200) {
      final List<dynamic> workerData = jsonDecode(response.body);
      final List<Worker> workers = workerData
          .map((data) {
            Worker? worker = Worker.fromMap(data);
            return worker;
          })
          .where((worker) => worker != null)
          .cast<Worker>()
          .toList();
      return workers;
    } else {
      throw Exception('Failed to fetch workers from the API');
    }
  }

  static Future<List<Worker>> getWorkersFromList(
      List<String> applicantIds) async {
    List<Worker> result = [];

    final CollectionReference workersRef = db.collection(workersCollections);

    // Iterating through each applicantId and retrieving the corresponding Worker
    for (String applicantId in applicantIds) {
      try {
        DocumentSnapshot documentSnapshot =
            await workersRef.doc(applicantId).get();
        if (documentSnapshot.exists) {
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
          Worker? worker = Worker.fromMap(
              data); // Using the fromMap method of the Worker class
          if (worker != null) {
            result.add(worker); // Only add if not null
          }
        }
      } catch (e) {
        print("Error fetching worker: $e");
      }
    }

    return result;
  }

  static Future<List<Worker>> getAllWorkers() async {
    List<Worker> workers = [];

    await db.collection(workersCollections).get().then((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        if (data['workerId'] != null) {
          Worker? worker = Worker.fromMap(data);
          if (worker != null) {
            workers.add(worker);
          }
        }
      }
    });

    // Sorting the workers list
    workers.sort((a, b) {
      // Handle dateCreated being 0 by considering 0 dates as "less recent"
      if (a.dateCreated == 0 && b.dateCreated == 0) return 0;
      if (a.dateCreated == 0) return 1;
      if (b.dateCreated == 0) return -1;

      // Both dates are non-zero, sort in descending order
      return b.dateCreated.compareTo(a.dateCreated);
    });

    return workers;
  }
}
