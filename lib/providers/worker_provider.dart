import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../data_providers/company_data_provider.dart';
import '../data_providers/user_data_provider.dart';
import '../data_providers/worker_data_provider.dart';
import '../models/app_user/app_user.dart';
import '../models/job.dart';
import '../models/job_post.dart';
import '../models/worker.dart';
import '../views/company/workers_home/worker_home_mobile/display_worker_from_selection.dart';
// Assuming the file containing the Worker class is named 'worker.dart'.

class WorkersProvider with ChangeNotifier {
  Worker? _worker;
  AppUser? appUser;

  int workerCurrentPageIndex = 0;

  Worker? get worker => _worker;

  List<Worker> selectedWorkers = [];
  Worker? selectedWorker;

  List<Worker> workersToDisplay = [];

  WorkersProvider() {
    getWorkers();
  }

  Future<void> getWorkers() async {
    workersToDisplay = await getAllWorkers();
    notifyListeners();
  }

  // TODO: Add a method to get all workers for the job with the given jobId.
  Future<void> getWorkersBySelection(BuildContext context, Job job) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DisplayWorkerFromSelection(
          title: job.title,
        ),
      ),
    );
    workersToDisplay = await getAllWorkers();
    notifyListeners();
  }

  update(AppUser? user) {
    appUser = user;
    notifyListeners();
  }

  void setSelectedWorker(Worker worker) {
    selectedWorker = worker;
    notifyListeners();
  }

  void getWorkersByJobID(String jobId) {
    // Get all workers for the job with the given jobId.
    WorkerDataProvider.getWorkersByJobID(jobId).then((workers) {
      selectedWorkers = workers
          .map((worker) {
            return Worker.fromMap(worker);
          })
          .where((worker) => worker != null)
          .cast<Worker>()
          .toList();

      if (selectedWorkers.isNotEmpty) {
        selectedWorker = selectedWorkers[0];
      }

      notifyListeners();
    });
  }

  void addInterestingWorker(AppUser? appUser, Worker worker) {
    // Update Companies Data
    CompanyDataProvider.addInterestingWorker(appUser, worker);
    // Update AppUSER details
    UserDataProvider.addInterestingWorker(appUser!.uid, worker.workerId);
  }

  //  Create Worker Profile Parameters

  Map<String, dynamic> previousParams = {};

  // Uploading Worker Credential

  // Create Parameter to Display Lists (Applied Users)
  List<Worker> appliedWorkers = [];

  Future<void> setDisplayLists(JobPost jobPost) async {
    if (jobPost.jobPostId.isEmpty) {
      return;
    }

    appliedWorkers = await WorkerDataProvider.getWorkerLists(
        jobPost.jobPostId, 'applicantUserIds');
    notifyListeners();
  }

  // Searching Parameters
  bool isSearching = false;

  Future<void> searchWorkers(String nameRelated, String locationRelated) async {
    selectedWorkers = [];
    selectedWorkers =
        await WorkerDataProvider.getWorkers(nameRelated, locationRelated);
    if (selectedWorkers.isEmpty) {
      EasyLoading.showError(
          'No Workers Found with $nameRelated $locationRelated');
    } else {
      selectedWorker = selectedWorkers.first;
      isSearching = true;
      notifyListeners();
    }
  }

  // initialize the Applicant list
  List<Worker> applicants = [];

  Future<bool> getApplicants(List<String> list) async {
    // Clearing existing applicants if any
    applicants.clear();
    applicants = await WorkerDataProvider.getWorkersFromList(list);
    notifyListeners();
    if (applicants.isEmpty) {
      EasyLoading.showError('No Applicants Found');
      return false;
    } else {
      return true;
    }
  }

  void setSearching(bool bool) {
    isSearching = bool;
    notifyListeners();
  }

  void checkIfAppUserIsNull() {
    if (appUser == null) {
      EasyLoading.showError('Please Sign In');
      return;
    }
  }

  Future<List<Worker>> getAllWorkers() async {
    return await WorkerDataProvider.getAllWorkers();
  }

  Future<void> getWorkersByPreferences() async {
    workersToDisplay.clear();
    workersToDisplay = await getAllWorkers();
    notifyListeners();
  }

// Any other methods related to the Worker can be added as required.
}
