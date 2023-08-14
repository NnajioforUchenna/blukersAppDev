import 'dart:typed_data';

import 'package:bulkers/data_providers/user_data_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../data_providers/company_data_provider.dart';
import '../data_providers/worker_data_provider.dart';
import '../models/app_user.dart';
import '../models/job_post.dart';
import '../models/reference.dart';
import '../models/work_experience.dart';
import '../models/worker.dart';
// Assuming the file containing the Worker class is named 'worker.dart'.

class WorkerProvider with ChangeNotifier {
  Worker? _worker;
  AppUser? appUser;

  int workerCurrentPageIndex = 0;

  Worker? get worker => _worker;

  List<Worker> selectedWorkers = [];
  Worker? selectedWorker;

  update(AppUser? user) {
    appUser = user;
    notifyListeners();
  }

  setSelectedWorker(Worker worker) {
    selectedWorker = worker;
    notifyListeners();
  }

  void getWorkersByJobID(String jobId) {
    print(jobId);
    // Get all workers for the job with the given jobId.
    WorkerDataProvider.getWorkersByJobID(jobId).then((workers) {
      selectedWorkers = workers.map((worker) {
        return Worker.fromMap(worker);
      }).toList();
      selectedWorker = selectedWorkers[0];
      notifyListeners();
    });
  }

  void addNewReference() {
    // Get all workers for the job with the given jobId.
    references.add({});
    notifyListeners();
  }

  void addInterestingWorker(AppUser? appUser, Worker worker) {
    // Update Companies Data
    CompanyDataProvider.addInterestingWorker(appUser, worker);
    // Update AppUSER details
    UserDataProvider.addInterestingWorker(appUser!.uid, worker.workerId);
  }

  //  Create Worker Profile Parameters
  Worker? newWorker;
  int workerProfileCurrentPageIndex = 0;
  List<Map<String, dynamic>> workExperience = [{}, {}];
  List<Map<String, dynamic>> references = [{}, {}];
  List<Map<String, dynamic>> professionalCredentials = [{}];
  Map<String, dynamic> previousParams = {};

  // Move to the next page in the worker's profile creation process.
  workerProfileNextPage() {
    workerProfileCurrentPageIndex++;
    notifyListeners();
  }

  workerProfileBackPage() {
    workerProfileCurrentPageIndex--;
    notifyListeners();
  }

  // Create a new Worker profile using the selected industries and jobs.
  void createWorkerProfile(context, List<String> selectedIndustries,
      Map<String, List<String>> selectedJobs) {
    if (appUser != null) {
      getMyProfile();

      // Saving the selected industries and jobs to the previousParams.
      previousParams['industries'] = selectedIndustries;
      previousParams['jobs'] = selectedJobs;

      newWorker = Worker.fromMap({
        'workerId': appUser!.uid,
        'emails': [appUser!.email!],
      });

      // Add the selected industries to the newWorker.
      newWorker!.industryIds = selectedIndustries;
      newWorker!.jobIds =
          selectedJobs.values.toList().expand((element) => element).toList();
      workerProfileNextPage();
    } else {
      // PLease sign in
      EasyLoading.showError('Please Sign In');
      Navigator.of(context).pushNamed('/login');
    }
  }

  // Add the worker's personal information to the newWorker.
  void addPersonalInformtion(String firstName, String middleName,
      String lastName, String day, String month, String year) {
    // Saving the personal information to the previousParams.
    previousParams['firstName'] = firstName;
    previousParams['middleName'] = middleName;
    previousParams['lastName'] = lastName;
    previousParams['birthDay'] = day;
    previousParams['birthMonth'] = month;
    previousParams['birthYear'] = year;

    // Saving the personal information to the newWorker.
    newWorker!.firstName = firstName;
    newWorker!.middleName = middleName;
    newWorker!.lastName = lastName;
    newWorker!.birthdate =
        DateTime(int.parse(year), int.parse(month), int.parse(day))
            .millisecondsSinceEpoch;

    workerProfileNextPage();
  }

  // Add Profile Photo to Worker
  Future<void> selectProfilePhoto(BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);

    EasyLoading.show(
      status: 'Uploading Your Profile Image...',
      maskType: EasyLoadingMaskType.black,
    );
    // Checking the size of the selected file
    if (image != null) {
      Uint8List bytes = await image.readAsBytes();
      int sizeInBytes = bytes.lengthInBytes;
      double sizeInMB = sizeInBytes / (1024 * 1024);

      if (sizeInMB > 10) {
        EasyLoading.dismiss();
        EasyLoading.showError(
            'Selected file is more than 10 MB. Please select a smaller file.');
        return;
      }
      print(appUser!.uid);
      String result = await WorkerDataProvider.uploadImageToFirebaseStorage(
          appUser!.uid, await image.readAsBytes(), image.name.split('.').last);
      // If the result is not an error, then update the logoUrl of the Worker.
      if (result != 'error') {
        appUser?.photoUrl = result;
        EasyLoading.dismiss();
        EasyLoading.showError('Uploaded your profile image successfully.');
        notifyListeners();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(
            'An error occurred while uploading your profile image. Please try again.');
      }
    }
  }

  // Uploading Worker Credential
  Future<Map<String, dynamic>> uploadCredential() async {
    Map<String, dynamic> returnFile = {};
    PlatformFile? filePlatformFile;
    String result = '';

    FilePickerResult? resultFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (resultFile != null) {
      returnFile['file'] = resultFile?.files.first;
      filePlatformFile = resultFile.files.first;
      EasyLoading.show(
        status: 'Uploading Your Credential...',
        maskType: EasyLoadingMaskType.black,
      );
      String resultUrl =
          await WorkerDataProvider.uploadCredentialToFirebaseStorage(
              appUser!.uid, filePlatformFile.bytes!, filePlatformFile.name);
      if (resultUrl != 'error') {
        appUser?.worker?.certificationsIds?.add(resultUrl);
        EasyLoading.dismiss();
        EasyLoading.showError('Uploaded your credential successfully.',
            duration: Duration(seconds: 3));
        notifyListeners();
        result = resultUrl;
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(
            'An error occurred while uploading your credential. Please try again.',
            duration: const Duration(seconds: 3));
      }
    }

    returnFile['url'] = result;
    return returnFile;
  }

  void setSkills(List<String> selectedSkills) {
// Saving the selected skills to the previousParams.
    previousParams['skills'] = selectedSkills;

    newWorker!.skillIds = selectedSkills;
    workerProfileNextPage();
  }

  // Uploading Worker Credential

  void addWorkExperience() {
    workExperience.add({});
    notifyListeners();
  }

  void addReference() {
    references.add({});
    notifyListeners();
  }

  void addCredential() {
    professionalCredentials.add({});
    notifyListeners();
  }

  void setWorkExperience() {
    workExperience.forEach((element) {
      print(element);
      newWorker!.workExperiences = [];
      newWorker!.workExperiences?.add(WorkExperience.fromMap(element));
    });
    workerProfileNextPage();
  }

  void setReference() {
    references.forEach((element) {
      newWorker!.references = [];
      newWorker!.references?.add(Reference.fromMap(element));
    });
    workerProfileNextPage();
  }

  void setResumeUrl(String pdfUrl) {
    newWorker!.pdfResumeUrl = pdfUrl;
  }

  void setResume(String text) {
    newWorker!.onlineResume = text;
    workerProfileNextPage();
    newWorker?.dateCreated = DateTime.now().millisecondsSinceEpoch;
    newWorker?.createdAt = DateTime.now().millisecondsSinceEpoch;
    newWorker?.modifiedAt = DateTime.now().millisecondsSinceEpoch;
    WorkerDataProvider.createWorkerProfile(newWorker!);
    UserDataProvider.updateUserWorkerProfile(appUser!.uid, newWorker!);
    previousParams.clear();
  }

  void getMyProfile() {
    WorkerDataProvider.getWorkerProfile(appUser!.uid).then((worker) {
      appUser!.worker = worker;
      notifyListeners();
    });
  }

  // Create Parameter to Display Lists (Applied Users)
  List<Worker> appliedWorkers = [];

  Future<void> setDisplayLists(JobPost jobPost) async {
    if (jobPost.jobPostId!.isEmpty) {
      return;
    }

    appliedWorkers = await WorkerDataProvider.getWorkerLists(
        jobPost!.jobPostId!, 'applicantUserIds');
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

// Any other methods related to the Worker can be added as required.
}
