import 'dart:async';
import 'dart:typed_data';

import 'package:bulkers/data_providers/company_data_provider.dart';
import 'package:bulkers/models/social_media_platform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../models/address.dart';
import '../models/app_user.dart';
import '../models/company.dart';
import '../models/job_post.dart';
import '../models/worker.dart';
// Assuming the file containing the Company class is named 'company.dart'.

class CompanyProvider with ChangeNotifier {
  Company? _company;
  AppUser? appUser;

  Company? get company => _company;

  Map<String, Worker> interestingWorkers = {};

  int companyProfileCurrentPageIndex = 0;

  update(AppUser? user) {
    appUser = user;
    notifyListeners();
  }

  Stream<List<Worker>> getInterestingWorkersStream() {
    if (appUser?.uid == null) {
      return Stream.value([]); // This returns an empty stream
    }
    return CompanyDataProvider.fetchInterestingWorkers(appUser!.uid).stream;
  }

  Stream<List<JobPost>> getMyJobPostsStream() {
    if (appUser?.uid == null) {
      return Stream.value([]); // This returns an empty stream
    }
    return CompanyDataProvider.fetchMyJobPosts(appUser!.uid).stream;
  }

  @override
  void dispose() {
    CompanyDataProvider.streamDispose();
    super.dispose();
  }

  Map<String, dynamic> createCompanyProfileData = {};
  Map<String, dynamic> previousParams = {};

  void addGeneralInformation(
      String companyName, String companySlogan, String shortDescription) {
    // Storing Previous Parameters
    previousParams.addAll({
      'companyName': companyName,
      'companySlogan': companySlogan,
      'shortDescription': shortDescription,
    });

    createCompanyProfileData.addAll({
      'companyId': appUser!.uid,
      'emails': [appUser!.email],
      'name': companyName,
      'companySlogan': companySlogan,
      'companyDescription': shortDescription,
    });
    companyProfileNextPage();
    notifyListeners();
  }

  void companyProfileNextPage() {
    companyProfileCurrentPageIndex++;
    notifyListeners();
  }

  void companyProfileBackPage() {
    companyProfileCurrentPageIndex--;
    notifyListeners();
  }

  // Add Profile Photo to Worker
  Future<void> selectCompanyLogo(BuildContext context) async {
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
      String result = await CompanyDataProvider.uploadImageToFirebaseStorage(
          appUser!.uid, await image.readAsBytes(), image.name.split('.').last);
      // If the result is not an error, then update the logoUrl of the Worker.
      if (result != 'error') {
        appUser?.photoUrl = result;
        EasyLoading.dismiss();
        EasyLoading.showError('Uploaded your profile image successfully.');
        notifyListeners();
        createCompanyProfileData['logoUrl'] = result;
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(
            'An error occurred while uploading your profile image. Please try again.');
      }
    }
  }

  void addContactDetails(String ext, String phoneNumber, String street,
      String city, String state, String postalCode, String country) {
    // Storing Previous Parameters
    previousParams.addAll({
      'ext': ext,
      'phoneNumber': phoneNumber,
      'street': street,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
    });

    Address address = Address(
      street: street,
      city: city,
      state: state,
      postalCode: postalCode,
      country: country,
    );

    createCompanyProfileData.addAll({
      'phoneNumbers': ['$ext-$phoneNumber'],
      'addresses': [address.toMap()],
    });
    companyProfileNextPage();
  }

  void addSocialMediaInfo(
      String website,
      List<TextEditingController> platformControllers,
      List<TextEditingController> linkControllers) {
    // Storing Previous Parameters
    previousParams.addAll({
      'website': website,
      'platformControllers': platformControllers,
      'linkControllers': linkControllers,
    });

    Map<String, dynamic> createCompanyProfileData = {};

    var socialPlatforms = [];

    // Run a pair loop on platformControllers and linkControllers
    for (int i = 0; i < platformControllers.length; i++) {
      String platform = platformControllers[i].text.trim();
      String link = linkControllers[i].text.trim();
      socialPlatforms
          .add(SocialMediaPlatform(platformName: platform, link: link).toMap());
    }

    // Add to the dictionary
    createCompanyProfileData['socialMediaPlatforms'] = socialPlatforms;
    createCompanyProfileData['website'] = website;

    companyProfileNextPage();
  }

  Future<bool> addCompanyCharacteristics(
      String companySize, String industry, String yearFounded) async {
    // Storing Previous Parameters
    previousParams.addAll({
      'companySize': companySize,
      'industry': industry,
      'yearFounded': yearFounded,
    });

    EasyLoading.show(
      status: 'Creating Your Company Profile...',
      maskType: EasyLoadingMaskType.black,
    );
    createCompanyProfileData.addAll({
      'totalEmployees': companySize,
      'companyIndustry': industry,
      'yearFounded': yearFounded,
    });
    companyProfileNextPage();
    bool result = await createCompanyProfile();
    EasyLoading.dismiss();
    return result;
  }

  Future<bool> createCompanyProfile() async {
    // prettyPrintMap(createCompanyProfileData);

    // Verify that it conforms to the Company model
    Company company = Company.fromMap(createCompanyProfileData);

    // Add the company to the database
    await CompanyDataProvider.createCompanyProfile(
        appUser!.uid, company.toMap());
    print('Company Profile Created Successfully');
    appUser?.companyTimelineStep = 2;

    notifyListeners();
    updateCompanyTimelineStep();
    previousParams.clear();
    return true;
  }

  void updateCompanyTimelineStep() {
    CompanyDataProvider.updateCompanyTimelineStep(appUser!.uid, 2);
    notifyListeners();
  }
}
