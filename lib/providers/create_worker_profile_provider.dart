import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../data_providers/user_data_provider.dart';
import '../data_providers/user_journey_data_provider.dart';
import '../data_providers/worker_data_provider.dart';
import '../models/app_user/app_user.dart';
import '../models/app_user/components/worker_resume_details.dart';
import '../models/app_user/components/worker_resume_form_tracker.dart';
import '../models/reference_form.dart';
import '../models/work_experience.dart';
import '../models/worker.dart';
import '../views/worker/create_worker_profile/create_worker_profile_components/credential_field.dart';
import '../views/worker/create_worker_profile/create_worker_profile_components/reference/reference_form.dart';
import '../views/worker/create_worker_profile/create_worker_profile_components/work_experience/work_experience_form.dart';

class CreateWorkerProfileProvider with ChangeNotifier {
  AppUser? appUser;

  update(AppUser? user) {
    appUser = user;
    notifyListeners();
  }

  //_____________________________Global Parameters _____________________________
  Map<String, dynamic> previousParams = {};
  int workerProfileCurrentPageIndex = 0;
  List<Map<String, dynamic>> professionalCredentials = [{}];

  PageController createProfilePageController = PageController();

  // Move to the next page in the worker's profile creation process.
    workerProfileNextPage() {
      workerProfileCurrentPageIndex++;
      createProfilePageController.animateToPage(workerProfileCurrentPageIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      notifyListeners();
      // wait 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        EasyLoading.dismiss();
      });
  }

  workerProfileBackPage() {
    workerProfileCurrentPageIndex--;
    createProfilePageController.animateToPage(workerProfileCurrentPageIndex,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    notifyListeners();
  }

  void checkIfAppUserIsNull() {
    if (appUser == null) {
      EasyLoading.showError('Please Sign In');
      return;
    }
  }

  //_____________________________Classification Page Parameters_____________________________

  List<String> selectedIndustries = [];
  Map<String, List<String>> selectedJobs = {};

  // Create a new Worker profile using the selected industries and jobs.
  void createWorkerProfile(context, List<String> selectedIndustries,
      Map<String, List<String>> selectedJobs) {
    if (appUser != null) {
      // // Saving the selected industries and jobs to the previousParams.
      previousParams['industries'] = selectedIndustries;
      previousParams['jobs'] = selectedJobs;
      //
      // // Create Worker Resume Form Tracker
      WorkerResumeFormTracker tracker = WorkerResumeFormTracker();
      tracker.isIndustriesAndJobsCompleted = true;

      // Create Worker Resume Details
      WorkerResumeDetails details = WorkerResumeDetails(tracker: tracker);
      // Store the selected industries and jobs in the details.
      details.industryIds = selectedIndustries;
      details.jobIds =
          selectedJobs.values.toList().expand((element) => element).toList();

      // Add the details to the appUser.
      appUser?.workerResumeDetails = details;

      // Update the appUser
      UserDataProvider.updateUser(appUser!);

      // Update User Journey Initialising Worker Profile
      UserJourneyDataProvider.updateInitiate(appUser!.uid);

      workerProfileNextPage();
    } else {
      // PLease sign in
      EasyLoading.showError('Please Sign In');
      Navigator.of(context).pushNamed('/login');
    }
  }

  //_____________________________Personal Information Page Parameters_____________________________

  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController birthMonthController = TextEditingController();
  TextEditingController birthYearController = TextEditingController();

  bool isFormComplete() {
    return firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        birthDayController.text.isNotEmpty &&
        birthMonthController.text.isNotEmpty &&
        birthYearController.text.isNotEmpty;
  }

  // Add the worker's personal information to the newWorker.
  void addPersonalInformtion() {
    // check if AppUser is null
    checkIfAppUserIsNull();

    // Saving the personal information to the previousParams.
    previousParams['firstName'] = firstNameController.text;
    previousParams['middleName'] = middleNameController.text;
    previousParams['lastName'] = lastNameController.text;
    previousParams['birthDay'] = birthDayController.text;
    previousParams['birthMonth'] = birthMonthController.text;
    previousParams['birthYear'] = birthYearController.text;

    // Saving the personal information to the newWorker.
    appUser!.workerResumeDetails?.tracker.isBasicInformationCompleted = true;
    appUser!.workerResumeDetails?.firstName = firstNameController.text;
    appUser!.workerResumeDetails?.middleName = middleNameController.text;
    appUser!.workerResumeDetails?.lastName = lastNameController.text;
    appUser!.workerResumeDetails?.birthdate = DateTime(
        int.parse(birthYearController.text),
        int.parse(birthMonthController.text),
        int.parse(birthDayController.text))
        .millisecondsSinceEpoch;

    // Update the appUser
    UserDataProvider.updateUser(appUser!);

    workerProfileNextPage();
  }

  //_____________________________Profile Photo Page Parameters_____________________________

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

      String result = await WorkerDataProvider.uploadImageToFirebaseStorage(
          appUser!.uid, await image.readAsBytes(), image.name.split('.').last);
      // If the result is not an error, then update the logoUrl of the Worker.
      if (result != 'error') {
        appUser?.photoUrl = result;
        appUser?.workerResumeDetails?.profilePhotoUrl = result;
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Uploaded your profile image successfully.');
        notifyListeners();
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(
            'An error occurred while uploading your profile image. Please try again.');
      }
    }
  }

  void updateWorkerProfilePhoto(String s) {
    appUser!.workerResumeDetails?.profilePhotoUrl = s;
    appUser?.workerResumeDetails?.tracker.isProfilePictureUploaded = true;
    UserDataProvider.updateUser(appUser!);
  }

  //_____________________________Professional Credentials Page Parameters_____________________________
  List<String> selectedSkills = [];
  List<CredentialField> credentialForms = [];

  void setSkills(List<String> selectedSkills) {
    // check if AppUser is null
    checkIfAppUserIsNull();

// Saving the selected skills to the previousParams.
    previousParams['skills'] = selectedSkills;

    appUser!.workerResumeDetails?.tracker.isSkillsCompleted = true;
    appUser!.workerResumeDetails?.skillIds = selectedSkills;

    UserDataProvider.updateUser(appUser!);

    workerProfileNextPage();
  }

  void addCredential() {
    professionalCredentials.add({});
    notifyListeners();
  }

  // Uploading Worker Credential
  Future<Map<String, dynamic>> uploadCredentialWeb() async {
    Map<String, dynamic> returnFile = {};
    PlatformFile? filePlatformFile;
    String result = '';

    FilePickerResult? resultFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (resultFile != null) {
      returnFile['file'] = resultFile.files.first;
      filePlatformFile = resultFile.files.first;
      EasyLoading.show(
        status: 'Uploading Your Credential...',
        maskType: EasyLoadingMaskType.black,
      );
      String resultUrl =
      await WorkerDataProvider.uploadCredentialToFirebaseStorageWeb(
          appUser!.uid, filePlatformFile.bytes!, filePlatformFile.name);
      if (resultUrl != 'error') {
        appUser?.workerResumeDetails?.certificationsIds?.add(resultUrl);
        EasyLoading.dismiss();
        EasyLoading.showSuccess('Uploaded your credential successfully.',
            duration: const Duration(seconds: 3));
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

  Future<Map<String, dynamic>> uploadCredentialMobile() async {
    Map<String, dynamic> returnFile = {};
    // Pick a PDF file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      withData: true,
      allowedExtensions: ['pdf'],
    );

    if (result != null && !kIsWeb) {
      EasyLoading.show(
        status: 'Uploading Your Credential...',
        maskType: EasyLoadingMaskType.black,
      );

      returnFile['file'] = result.files.first;
      // get File path
      File file = File(result.files.single.path!);
      String resultUrl =
      await WorkerDataProvider.uploadCredentialToFirebaseStorageMobile(
          appUser!.uid, file, result.files.single.name);

      if (resultUrl != 'error') {
        appUser?.workerResumeDetails?.certificationsIds?.add(resultUrl);

        EasyLoading.dismiss();
        EasyLoading.showSuccess('Uploaded your credential successfully.',
            duration: const Duration(seconds: 3));
        notifyListeners();
        returnFile['url'] = resultUrl;
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(
            'An error occurred while uploading your credential. Please try again.',
            duration: const Duration(seconds: 3));
      }
    }
    return returnFile;
  }

  //_____________________________Work Experience Page Parameters_____________________________
  List<WorkExperienceForm> workExperienceForms = [];
  List<Map<String, dynamic>> workExperience = [{}];

  void addWorkExperience() {
    workExperience.add({});
    notifyListeners();
  }

  void setWorkExperience() {
    // check if AppUser is null
    checkIfAppUserIsNull();

    for (var element in workExperience) {
      appUser!.workerResumeDetails?.workExperiences = [];
      appUser!.workerResumeDetails?.workExperiences
          ?.add(WorkExperience.fromMap(element));
    }
    UserDataProvider.updateUser(appUser!);
    workerProfileNextPage();
  }

  //_____________________________Reference Page Parameters_____________________________
  List<ReferenceFormWidget> referenceForms = [];
  List<Map<String, dynamic>> references = [{}];

  void addReference() {
    references.add({});
    notifyListeners();
  }

  void setReference() {
    // check if AppUser is null
    checkIfAppUserIsNull();

    if (references.isEmpty) {
      EasyLoading.showError('Add at least 1 reference');
    } else {
      for (var element in references) {
        appUser?.workerResumeDetails?.references = [];
        if (element.isNotEmpty) {
          appUser?.workerResumeDetails?.references
              ?.add(ReferenceForm.fromMap(element));
        }
      }
      UserDataProvider.updateUser(appUser!);
      workerProfileNextPage();
    }
  }

  void setResumeUrl(String pdfUrl) {
    // check if AppUser is null
    checkIfAppUserIsNull();

    appUser?.workerResumeDetails?.pdfResumeUrl = pdfUrl;
  }

  void addNewReference() {
    // Get all workers for the job with the given jobId.
    print('Adding new reference');
    references.add({});
    notifyListeners();
  }

  //_____________________________Resume Page Parameters_____________________________
  TextEditingController linkedInUrlController = TextEditingController();

  void setResume(String text) {
    // check if AppUser is null
    checkIfAppUserIsNull();

    appUser?.workerResumeDetails?.linkedInUrl = text;
    UserDataProvider.updateUser(appUser!);
    workerProfileNextPage();

    // Create New Worker and Add to Database
    Worker newWorker = Worker.fromAppUser(appUser!);

    newWorker.dateCreated = DateTime.now().millisecondsSinceEpoch;
    newWorker.createdAt = DateTime.now().millisecondsSinceEpoch;
    newWorker.modifiedAt = DateTime.now().millisecondsSinceEpoch;
    WorkerDataProvider.createWorkerProfile(newWorker);

    // Update User Journey as Member
    UserJourneyDataProvider.updateMember(appUser!.uid);
    // previousParams.clear();
  }

  //____________________________Clearing All Records_____________________________
  clearAllRecords() {
    selectedIndustries = [];
    selectedJobs = {};
    firstNameController.clear();
    middleNameController.clear();
    lastNameController.clear();
    birthDayController.clear();
    birthMonthController.clear();
    birthYearController.clear();
    workerProfileCurrentPageIndex = 0;
    createProfilePageController.jumpToPage(0);
    notifyListeners();
  }
}
