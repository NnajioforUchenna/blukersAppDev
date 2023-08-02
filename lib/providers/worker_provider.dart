import 'package:flutter/material.dart';

import '../data_providers/company_data_provider.dart';
import '../data_providers/worker_data_provider.dart';
import '../models/app_user.dart';
import '../models/worker.dart';
// Assuming the file containing the Worker class is named 'worker.dart'.

class WorkerProvider with ChangeNotifier {
  Worker? _worker;

  int workerCurrentPageIndex = 0;

  Worker? get worker => _worker;

  List<Worker> selectedWorkers = [];
  Worker? selectedWorker;

  update(AppUser? user) {}

  setSelectedWorker(Worker worker) {
    selectedWorker = worker;
    notifyListeners();
  }

  void getWorkersByJobID(String jobId) {
    // Get all workers for the job with the given jobId.
    WorkerDataProvider.getWorkersByJobID(jobId).then((workers) {
      selectedWorkers = workers.map((worker) {
        return Worker.fromMap(worker);
      }).toList();
      selectedWorker = selectedWorkers[0];
      notifyListeners();
    });
  }

  void addInterestingWorker(AppUser? appUser, Worker worker) {
    CompanyDataProvider.addInterestingWorker(appUser, worker);
  }

// Any other methods related to the Worker can be added as required.
}
