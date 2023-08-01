import 'package:bulkers/data_providers/user_data_provider.dart';
import 'package:bulkers/models/app_user.dart';
import 'package:bulkers/models/worker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;

class CompanyDataProvider {
  static void addInterestingWorker(AppUser? appUser, Worker worker) {
    CollectionReference companiesCollection = firestore.collection('Companies');
    if (appUser == null) return;
    companiesCollection.doc(appUser!.uid).set(
      {
        'interestingWorkers': FieldValue.arrayUnion([worker.workerId]),
      },
      SetOptions(merge: true),
    ).catchError((error) {
      print("Error adding user to Firestore: $error");
    });
  }

  static Future<List<Worker>> getInterestingWorkers(String companyId) async {
    print('getInterestingWorkers called');
    DocumentSnapshot doc =
        await db.collection('Companies').doc(companyId).get();

    if (doc.exists) {
      Map<String, dynamic> data = doc.data()
          as Map<String, dynamic>; // Type casting to Map<String, dynamic>
      List<dynamic> workerList = data['interestingWorkers'];
      print(workerList);

      List<Worker> returnWorkerList = [];

      for (var workerId in workerList) {
        DocumentSnapshot doc =
            await db.collection('Workers').doc(workerId).get();
        Map<String, dynamic> workerData = doc.data()
            as Map<String, dynamic>; // Type casting to Map<String, dynamic>
        returnWorkerList.add(Worker.fromMap(workerData));
      }

      return returnWorkerList;
    } else {
      return [];
    }
  }
}
