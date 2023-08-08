import 'dart:io';

import 'package:bulkers/data_providers/user_data_provider.dart';
import 'package:bulkers/providers/chat_provider.dart';
import 'package:bulkers/services/notification_service.dart';
import 'package:bulkers/services/user_shared_preferences_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../common_files/constants.dart';
import '../models/address.dart';
import '../models/app_user.dart';
import '../models/company.dart';
import '../models/worker.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;
  User? get user => _user;

  AppUser? _appUser;
  AppUser? get appUser => _appUser;

  String userRole = "company";

  switchUserRole() {
    if (userRole == "company") {
      userRole = "worker";
    } else {
      userRole = "company";
    }
    notifyListeners();
  }

  int registerCurrentPageIndex = 0;

  UserProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      if (user != null) {
        initializeAppUser(user.uid);
      }
      notifyListeners();
    });
  }

  Future<void> initializeAppUser(uid) async {
    _appUser = await UserDataProvider.getAppUser(uid);
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    _appUser = null;
    notifyListeners();
  }

  int currentPageIndex = 0;

  void setRegisterPageIndex() {
    registerCurrentPageIndex++;
    notifyListeners();
  }

  Future<void> registerUser(
      {required String email,
      required String password,
      required String userType,
      required ChatProvider chatProvider}) async {
    // Display a loading indicator with a message to the user.
    EasyLoading.show(
      status: 'Creating your Account...',
      maskType: EasyLoadingMaskType.black,
    );

    // Attempt to register the user.
    var result = await UserDataProvider.registerUser(email, password);

    // Check if registration was successful.
    if (result['success']) {
      // Prepare the user data for storage.
      AppUser appUser = AppUser.fromSignUp(
          uid: result['userCredential'].user!.uid,
          email: email,
          isLoginInformation: true,
          registeredAs: userType);

      // Set the _appUser
      _appUser = appUser;

      // Add to Shared Preferences
      UserSharedPreferencesServices.create(appUser);

      // Store the user data in the database.
      UserDataProvider.registerUserToDatabase(appUser);
      //
      if (!kIsWeb) {
        await NotificationService.registerNotification(
            _appUser!.uid, chatProvider);
        NotificationService.configLocalNotification();
      }
      // Dismiss the loading indicator.
      EasyLoading.dismiss();

      // Proceed to the next registration page.
      setRegisterPageIndex();
    } else {
      // Print and display any errors that occurred during registration.
      print("Error: ${result['error']}");
      EasyLoading.dismiss();
      EasyLoading.showError(result['error'],
          duration: const Duration(seconds: 3));
    }
  }

  void updateWorker(
      {required String name,
      required String lastName,
      required String description}) {
    EasyLoading.show(
      status: 'Adding Basic Information...',
      maskType: EasyLoadingMaskType.black,
    );
    Worker worker = Worker.fromSignUp(
      workerId: appUser!.uid,
      lastName: lastName,
      firstName: name,
      email: appUser!.email!,
      workerBriefDescription: description,
    );
    UserDataProvider.updateWorkerBasicInformation(worker);
    _appUser!.worker = worker;
    _appUser!.isBasicInformation = true;
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
      emails: [appUser!.email!],
    );
    UserDataProvider.updateBasicInformation(company);
    _appUser!.company = company;
    _appUser!.isBasicInformation = true;
    EasyLoading.dismiss();
    setRegisterPageIndex();
  }

  void addingContactInformation(String ext, String phoneNumber, String street,
      String city, String state, String postalCode, String country) {
    EasyLoading.show(
      status: 'Adding Contact Information...',
      maskType: EasyLoadingMaskType.black,
    );

    Address address = Address(
        street: street,
        city: city,
        state: state,
        postalCode: postalCode,
        country: country);

    String completePhoneNumber = "$ext-$phoneNumber";

    UserDataProvider.updateContactInformation(
        completePhoneNumber, address, appUser!.uid);

    _appUser!.address = address;
    _appUser!.phoneNumber = completePhoneNumber;
    _appUser!.isContactInformation = true;

    EasyLoading.dismiss();
    setRegisterPageIndex();
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

    await UserDataProvider.updateWorkerInfo(worker.toMap(), _appUser!.uid);

    _appUser!.worker = worker;

    EasyLoading.dismiss();
    notifyListeners();
    // setRegisterPageIndex();
  }

  void navigate(BuildContext context, int index) {
    currentPageIndex = index;
    if (userRole == "worker") {
      Navigator.pushNamedAndRemoveUntil(
          context, routesWorker[index], (Route<dynamic> route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, routesCompany[index], (Route<dynamic> route) => false);
    }

    // notifyListeners();
  }

  Future<void> loginAppUser(
      {required BuildContext context,
      required String email,
      required String password,
      required ChatProvider chatProvider}) async {
    // Display a loading indicator with a message to the user.
    EasyLoading.show(
      status: 'Logging you in...',
      maskType: EasyLoadingMaskType.black,
    );

    // Attempt to log the user in.
    var result = await UserDataProvider.loginUser(email, password);

    // Check if the login was successful.
    if (result['success']) {
      // Fetch user details from the database or wherever necessary.
      // This step assumes that you have a method to get user details after they log in.
      AppUser? appUser4DB =
          await UserDataProvider.getAppUser(result['userCredential'].user!.uid);

      // Set the _appUser
      _appUser = appUser4DB;

      // Add to Shared Preferences
      if (appUser4DB != null) {
        UserSharedPreferencesServices.create(appUser4DB);
      }
      if (kIsWeb) {
        await NotificationService.registerNotification(
            _appUser!.uid, chatProvider);
        NotificationService.configLocalNotification();
      }
      notifyListeners();

      // Dismiss the loading indicator.
      EasyLoading.dismiss();

      // Navigate to the home page.
      // if (userRole == "worker") {
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, '/jobs', (Route<dynamic> route) => false);
      // } else {
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, '/workers', (Route<dynamic> route) => false);
      // }
    } else {
      // Print and display any errors that occurred during login.
      print("Error: ${result['error']}");
      EasyLoading.dismiss();
      EasyLoading.showError(result['error'],
          duration: const Duration(seconds: 3));
    }
  }

  Future<void> resetAppUserPassword({
    required BuildContext context,
    required String email,
  }) async {
    // Display a loading indicator with a message to the user.
    EasyLoading.show(
      status: 'Sending password reset link...',
      maskType: EasyLoadingMaskType.black,
    );

    // Attempt to send a password reset email.
    var result = await UserDataProvider.resetPassword(email);

    // Check if the reset link was sent successfully.
    if (result['success']) {
      // Dismiss the loading indicator.
      EasyLoading.dismiss();
      notifyListeners();

      // Show success message.
      EasyLoading.showSuccess(
        result['message'],
        duration: const Duration(seconds: 3),
      );
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', (Route<dynamic> route) => false);
    } else {
      // Print and display any errors that occurred during the password reset attempt.
      print("Error: ${result['error']}");
      EasyLoading.dismiss();
      EasyLoading.showError(result['error'],
          duration: const Duration(seconds: 3));
    }
  }

  Future<String?> ontapGallery(String storagePath) async {
    ImagePicker picker = ImagePicker();
    XFile? gallery =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
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
        flow: image, path: "$storagePath${appUser!.uid}");

    // await PrefService.setValue(PrefKeys.imageId, imageUrl ?? "");
    //fbImageUrl.value = imageUrl ?? "";
    await Future.delayed(Duration(seconds: 2));

    EasyLoading.dismiss();
    return imageUrl;
    // imagePicker();
  }

  Future<String?> ontapCamera(String storagePath) async {
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
        flow: image, path: "$storagePath${appUser!.uid}");

    // await PrefService.setValue(PrefKeys.imageId, imageUrl ?? "");
    //fbImageUrl.value = imageUrl ?? "";
    await Future.delayed(Duration(seconds: 2));

    EasyLoading.dismiss();
    return imageUrl;
    // imagePicker();
  }

  Future<String?> onTapPdf(String storagePath) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: [
        'pdf',
        /* 'xlsx',
        'xlsm',
        'xls',
        'ppt',
        'pptx',
        'doc',
        'docx',
        'txt',
        'text',
        'rtf',
        'zip',*/
      ],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      EasyLoading.show(
        status: 'Uploading your Profile Pic...',
        maskType: EasyLoadingMaskType.black,
      );
      // List<PlatformFile> fileList = result.files;

      // debugPrint("FILES : $file");
      // filepath.value = file.name.toString();
      // final kb = file.size / 1024;
      // final kbVal = kb.ceil().toInt();
      // final mb = kb / 1024;
      // fileSize?.value = kbVal;
      // filesize = mb;

      // if (kDebugMode) {
      //   print(filesize);
      // }

      // debugPrint("filepath $filepath FileSize ${fileSize?.value}  $kbVal");
      // {
      //   PlatformFile file = result.files.first;
      //   // List<PlatformFile> fileList = result.files;

      //   debugPrint("FILES : $file");
      //   filepath.value = file.name.toString();
      //   fileSize?.value = file.size.ceil().toInt();
      //   isPdfUploadError.value = false;

      //   debugPrint("filepath $filepath FileSize $fileSize");
      // }

      final File fileForFirebase = File(file.path!);

      String? imageUrl = await UserDataProvider.uploadImage(
          flow: fileForFirebase, path: "$storagePath${appUser!.uid}");

      // await PrefService.setValue(PrefKeys.imageId, imageUrl ?? "");
      //fbImageUrl.value = imageUrl ?? "";
      await Future.delayed(Duration(seconds: 2));

      EasyLoading.dismiss();
      return imageUrl;
      // return pdfUrl;
    } else {
      // User canceled the picker
      return "";
    }
  }
}
