part of 'user_provider.dart';

extension UpdatingProfileFunctions on UserProvider {
  void updateIndustriesAndJobs() {
    updatingInformation(() async {
      if (appUser != null) {
        UserDataProvider.updateWorkerIndustriesAndJobs(appUser);
      }
    });
  }

  void updateUserInformation({
    required String firstName,
    required String middleName,
    required String lastName,
    required String description,
  }) {
    updatingInformation(() async {
      UserDataProvider.updateUserInformation(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        description: description,
        uid: appUser!.uid,
      );
    });
  }

  // for company basic information
  void updateCompanyBasicInformation({
    required String name,
    required List<String> email,
    required List<String> phoneNumber,
    required String description,
  }) {
    updatingInformation(() async {
      UserDataProvider.updateCompanyBasicInformation(
        name: name,
        description: description,
        email: email,
        phoneNumber: phoneNumber,
        uid: appUser!.uid,
      );
    });
  }

  // for company information
  void updateCompanyInformation({
    required int yearFounded,
    required int totalEmployees,
  }) {
    updatingInformation(() async {
      UserDataProvider.updateCompanyInformation(
        yearFounded: yearFounded,
        totalEmployees: totalEmployees,
        uid: appUser!.uid,
      );
    });
  }

  void updateAppUserCategory(
      List<String> selectedIndustries, Map<String, List<String>> selectedJobs) {
    if (appUser != null && appUser?.workerResumeDetails != null) {
      appUser?.workerResumeDetails?.industryIds = selectedIndustries;
      appUser?.workerResumeDetails?.jobIds =
          selectedJobs.values.expand((element) => element).toList();
      UserDataProvider.updateWorkerIndustriesAndJobs(appUser);
    }
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

  Future<Map<String, dynamic>> uploadResume() async {
    Map<String, dynamic> result = {
      'url': '',
    };
    if (kIsWeb) {
      result = await uploadCredentialWeb();
    } else {
      result = await uploadCredentialMobile();
    }
    String url = result['url'];
    if (url.isNotEmpty) {
      if (appUser != null && appUser?.workerResumeDetails != null) {
        appUser!.workerResumeDetails!.pdfResumeUrl = url;
        UserDataProvider.updateResumeUrl(appUser!.uid, url);
      }

      return result;
    }
    return {};
  }
}
