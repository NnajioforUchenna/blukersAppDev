part of 'user_provider.dart';

extension CreatingUserProfile on UserProvider {
  void updateWorker({
    required String name,
    required String lastName,
    required String description,
  }) {
    EasyLoading.show(
      status: 'Adding Basic Information...',
      maskType: EasyLoadingMaskType.black,
    );

    if (appUser != null) {
      appUser?.registrationDetails?.firstName = name;
      appUser?.registrationDetails?.lastName = lastName;
      appUser?.registrationDetails?.shortDescription = description;
      appUser?.registrationDetails?.status.isAppUserInformation = true;

      // Update the user data in the database.
      UserDataProvider.registerUserToDatabase(appUser!);
    }

    EasyLoading.dismiss();
    setRegisterPageIndex();
  }

  void updateCompany(
      {required String companyName, required String description}) {
    EasyLoading.show(
      status: 'Adding Basic Information...',
      maskType: EasyLoadingMaskType.black,
    );
    Company company = Company.fromSignUp(
      companyId: appUser!.uid,
      companyDescription: description,
      name: companyName,
      emails: [appUser!.email],
    );
    UserDataProvider.updateBasicInformation(company);
    _appUser!.company = company;
    EasyLoading.dismiss();
    setRegisterPageIndex();
  }

  void addingContactInformation(String ext, String phoneNumber) {
    // String street,
    //       String city, String state, String postalCode, String country
    EasyLoading.show(
      status: 'Adding Contact Information...',
      maskType: EasyLoadingMaskType.black,
    );

    String completePhoneNumber = "$ext-$phoneNumber";

    UserDataProvider.updateContactInformation(
        completePhoneNumber, appUser!.uid);
    // _appUser!.address = address;
    _appUser!.phoneNumber = completePhoneNumber;
    EasyLoading.dismiss();
    // setRegisterPageIndex();
  }

  Future<void> updateUserBasicInfo(
      String displayName, String phoneNo, String language) async {
    EasyLoading.show(
      status: 'Updating your Basic Info...',
      maskType: EasyLoadingMaskType.black,
    );

    Map<String, dynamic> info = {
      "displayName": displayName,
      "phoneNumber": phoneNo,
      "language": language,
    };

    await UserDataProvider.updateUserBasicInfo(info, _appUser!.uid);

    _appUser!.displayName = displayName;
    _appUser!.phoneNumber = phoneNo;
    _appUser!.language = language;

    EasyLoading.dismiss();
    notifyListeners();
    // setRegisterPageIndex();
  }

  Future<void> updateUserProfilePic(String imageUrl) async {
    EasyLoading.show(
      status: 'Updating your Basic Info...',
      maskType: EasyLoadingMaskType.black,
    );

    await UserDataProvider.updateUserProfilePic(
        {"photoUrl": imageUrl}, _appUser!.uid);

    _appUser!.photoUrl = imageUrl;

    EasyLoading.dismiss();
    notifyListeners();
    // setRegisterPageIndex();
  }

  Future<void> updateCompanyInfo(Company company) async {
    EasyLoading.show(
      status: 'Updating your Basic Info...',
      maskType: EasyLoadingMaskType.black,
    );

    await UserDataProvider.updateCompanyInfo(company.toMap(), _appUser!.uid);

    _appUser!.company = company;

    EasyLoading.dismiss();
    notifyListeners();
    // setRegisterPageIndex();
  }

  Future<void> updateWorkerInfo(Worker worker) async {
    EasyLoading.show(
      status: 'Updating your Basic Info...',
      maskType: EasyLoadingMaskType.black,
    );

    UserDataProvider.updateUser(appUser!);

    EasyLoading.dismiss();
    notifyListeners();
    // setRegisterPageIndex();
  }

  void updateUI(String workerId) {
    appUser?.company?.interestingWorkersIds.add(workerId);
    notifyListeners();
  }

  Future<String?> ontapGallery(String storagePath) async {
    // FilePickerResult? gallery = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['png'],
    // );
    ImagePicker imagePicker = ImagePicker();
    final XFile? gallery =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (gallery == null) {
      return "";
    }
    EasyLoading.show(
      status: 'Uploading your Profile Pic...',
      maskType: EasyLoadingMaskType.black,
    );
    Uint8List bytes = await gallery.readAsBytes();
    int sizeInBytes = bytes.lengthInBytes;
    double sizeInMB = sizeInBytes / (1024 * 1024);

    if (sizeInMB > 10) {
      EasyLoading.dismiss();
      EasyLoading.showError(
          'Selected file is more than 10 MB. Please select a smaller file.');
      return "";
    }

    String? result = await UserDataProvider.uploadImage(
      image: await gallery.readAsBytes(),
      path: "$storagePath${appUser!.uid}",
    );
    // If the result is not an error, then update the logoUrl of the Worker.
    if (result != 'error') {
      // appUser?.photoUrl = result;
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Uploaded your profile image successfully.');
      return result;
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(
          'An error occurred while uploading your profile image. Please try again.');
      return "";
    }

    //Get.back();
    // EasyLoading.show(
    //   status: 'Uploading your Profile Pic...',
    //   maskType: EasyLoadingMaskType.black,
    // );
    // String path = gallery.path;
    // File image = File(path);
    // String? imageUrl = await UserDataProvider.uploadImage(
    //     flow: image, path: "$storagePath${appUser!.uid}");

    // // await PrefService.setValue(PrefKeys.imageId, imageUrl ?? "");
    // //fbImageUrl.value = imageUrl ?? "";
    // await Future.delayed(Duration(seconds: 2));

    // EasyLoading.dismiss();
    // return imageUrl;
    // // imagePicker();
  }

  Future<String?> ontapCamera(String storagePath) async {
    // return "";
    ImagePicker picker = ImagePicker();
    XFile? gallery = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 15,
        preferredCameraDevice: CameraDevice.front);
    if (gallery == null) {
      return "";
    }

    //Get.back();
    EasyLoading.show(
      status: 'Uploading your Profile Pic...',
      maskType: EasyLoadingMaskType.black,
    );
    String path = gallery.path;
    File image = File(path);
    String? imageUrl = await UserDataProvider.uploadImage(
        image: image.readAsBytesSync(), path: "$storagePath${appUser!.uid}");

    // await PrefService.setValue(PrefKeys.imageId, imageUrl ?? "");
    //fbImageUrl.value = imageUrl ?? "";
    await Future.delayed(const Duration(seconds: 2));

    EasyLoading.dismiss();
    return imageUrl;
    // imagePicker();
  }

  Future<String?> onTapPdf(String storagePath) async {
    FilePickerResult? gallery = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf'], withData: true);
    if (gallery == null) {
      return "";
    }
    EasyLoading.show(
      status: 'Uploading your Pdf Resume...',
      maskType: EasyLoadingMaskType.black,
    );

    PlatformFile? filePlatformFile = gallery.files.first;
    String? result = await UserDataProvider.uploadImage(
      image: filePlatformFile.bytes!,
      path: "$storagePath${appUser!.uid}",
    );
    // If the result is not an error, then update the logoUrl of the Worker.
    if (result != 'error') {
      // appUser?.photoUrl = result;
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Uploaded your profile image successfully.');
      return result;
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError(
          'An error occurred while uploading your profile image. Please try again.');
      return "";
    }
  }
}
