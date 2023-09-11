// import 'dart:io';
import 'package:blukers/providers/app_versions_provider.dart';
import 'package:blukers/providers/chat_provider.dart';
import 'package:blukers/utils/styles/theme_colors.dart';
import 'package:blukers/utils/styles/theme_text_styles.dart';
import 'package:blukers/views/common_views/components/app_version_display.dart';
import 'package:blukers/views/common_views/components/icon_text_404.dart';
import 'package:blukers/views/common_views/components/profile_divider.dart';
import 'package:blukers/views/common_views/info_display_component.dart';
import 'package:blukers/views/common_views/profile_dialog.dart';
import 'package:blukers/views/common_views/profile_section.dart';
import 'package:blukers/views/company/profile_components/edit_basic_profile.dart';
import 'package:blukers/views/company/profile_components/user_basic_profile_details.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../providers/user_provider.dart';
import '../auth/common_widget/login_or_register.dart';
import '../common_views/page_template/page_template.dart';
import '../common_views/select_industry_components/industry_jobs_dropdown.dart';

class WorkerProfile extends StatefulWidget {
  const WorkerProfile({super.key});

  @override
  State<WorkerProfile> createState() => _WorkerProfileState();
}

class _WorkerProfileState extends State<WorkerProfile> {
  bool showBasicInfo = false;
  bool showIndustries = false;
  bool showPdfResume = false;

  // Future<File?> viewPdf(String pdfUrl) async {
  //   EasyLoading.show(
  //     status: 'Opening file viewer...',
  //     maskType: EasyLoadingMaskType.black,
  //   );
  //   Completer<File> completer = Completer();
  //   if (kDebugMode) {
  //     print("Start download file from internet!");
  //   }
  //   try {
  //     // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
  //     // final url = "https://pdfkit.org/docs/guide.pdf";
  //     var url = pdfUrl;
  //     if (url == null || url == "") {
  //       return null;
  //     }
  //     final filename = url.substring(url.lastIndexOf("/") + 1);
  //     var request = await HttpClient().getUrl(Uri.parse(url));
  //     var response = await request.close();
  //     var bytes = await consolidateHttpClientResponseBytes(response);
  //     var dir = await getApplicationDocumentsDirectory();
  //     if (kDebugMode) {
  //       print("Download files");
  //     }
  //     if (kDebugMode) {
  //       print("${dir.path}/$filename");
  //     }
  //     File file = File("${dir.path}/$filename");
  //     await file.writeAsBytes(bytes, flush: true);
  //     completer.complete(file);
  //     // loader = false;
  //   } catch (e) {
  //     throw Exception('Error parsing asset file!');
  //   }
  //   EasyLoading.dismiss();
  //   return completer.future;
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    UserProvider up = Provider.of<UserProvider>(context);
    ChatProvider chatProvider = Provider.of<ChatProvider>(context);
    AppVersionsProvider avp = Provider.of<AppVersionsProvider>(context);

    if (!kIsWeb) {
      avp.checkForUpdate(context);
    }

    return PageTemplate(
      child: up.appUser == null
          ? LoginOrRegister()
          : SingleChildScrollView(
              child: Column(
                children: [
                  // const Text(
                  //   "Profile",
                  //   style: TextStyle(
                  //     color: ThemeColors.primaryThemeColor,
                  //     fontSize: 30,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Container(
                          // decoration: BoxDecoration(
                          //   color: Colors.red,
                          // ),
                          width: 200,
                          height: 200,
                          child: up.appUser!.photoUrl != null &&
                                  up.appUser!.photoUrl != ""
                              ? FadeInImage.assetNetwork(
                                  placeholder: "assets/images/loading.jpeg",
                                  image: up.appUser!.photoUrl!,
                                  //width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.fitWidth,
                                )
                              // : Image.asset("assets/images/userDefaultProfilePic.png"),
                              : FittedBox(
                                  child: Image.asset(
                                      "assets/images/userDefaultProfilePic.png"),
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet<void>(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  //  height: 450,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(45),
                                      topRight: Radius.circular(45),
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const SizedBox(height: 30),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .changeProfilePicture,
                                          style: ThemeTextStyles
                                              .headingThemeTextStyle,
                                        ),
                                        // const SizedBox(height: 20),
                                        if (!kIsWeb)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 18, vertical: 18),
                                            child: Container(
                                              //  height: 170,
                                              width: 500,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      const Color(0xffF3ECFF),
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      String? imageUrl =
                                                          await up.ontapCamera(
                                                              "/profile_images/");
                                                      if (imageUrl != "") {
                                                        await up
                                                            .updateUserProfilePic(
                                                                imageUrl!);
                                                      }
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Container(
                                                      height: 70,
                                                      width: 70,
                                                      margin: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 100,
                                                          vertical: 10),
                                                      decoration: BoxDecoration(
                                                        color: ThemeColors
                                                            .blukersBlueThemeColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(80),
                                                      ),
                                                      child: const Icon(
                                                        Icons.camera_alt,
                                                        size: 40,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .takePhoto,
                                                    style: ThemeTextStyles
                                                        .headingThemeTextStyle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 18),
                                          child: Container(
                                            //   height: 120,
                                            width: 500,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color(0xffF3ECFF),
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(5),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    String? imageUrl =
                                                        await up.ontapGallery(
                                                            "/profile_images/");
                                                    if (imageUrl != "") {
                                                      await up
                                                          .updateUserProfilePic(
                                                              imageUrl!);
                                                    }
                                                    Navigator.of(context).pop();
                                                    print(imageUrl);
                                                  },
                                                  child: Container(
                                                    height: 70,
                                                    width: 70,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 100,
                                                        vertical: 10),
                                                    decoration: BoxDecoration(
                                                      color: ThemeColors
                                                          .blukersBlueThemeColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              80),
                                                    ),
                                                    child: const Image(
                                                      image: AssetImage(
                                                          "assets/images/galleryImage.png"),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .fromGallery,
                                                  style: ThemeTextStyles
                                                      .headingThemeTextStyle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundColor: ThemeColors.secondaryThemeColor,
                            child: Icon(
                              UniconsLine.pen,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    up.appUser!.displayName ?? "Display Name",
                    style:
                        ThemeTextStyles.landingPageSubtitleThemeTextStyle.apply(
                      color: ThemeColors.blukersBlueThemeColor,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ProfileSection(
                    heading: AppLocalizations.of(context)!.userInformation,
                    menuIcon: UniconsLine.user_circle,
                    icon: UniconsLine.pen,
                    showBasicInfo: showBasicInfo,
                    onClickSection: () {
                      print("Section clicked");
                      setState(() {
                        showBasicInfo = !showBasicInfo;
                      });
                    },
                    onClickEdit: () {
                      print("Edit clicked");
                      showDialog(
                        context: context,
                        builder: (context) => ProfileDialog(
                          child: EditBasicProfile(
                            displayName: up.appUser!.displayName ?? "",
                            phoneNo: up.appUser!.phoneNumber ?? "",
                            language: up.appUser!.language ?? "",
                          ),
                        ),
                      );
                    },
                  ),
                  if (showBasicInfo)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: UserBasicProfileDetail(
                        displayName: up.appUser!.displayName ?? "Not Available",
                        email: up.appUser!.email ?? "Not Available",
                        phoneNo: up.appUser!.phoneNumber ?? "Not Available",
                        language: up.appUser!.language ?? "Not Available",
                      ),
                    ),
                  const ProfileDivider(),
                  ProfileSection(
                    heading: AppLocalizations.of(context)!.industriesSlashJobs,
                    menuIcon: UniconsLine.hard_hat,
                    icon: UniconsLine.pen,
                    showBasicInfo: showIndustries,
                    showEditIcon: false,
                    onClickSection: () {
                      print("Section clicked");
                      setState(() {
                        showIndustries = !showIndustries;
                      });
                    },
                  ),
                  if (showIndustries && up.appUser!.worker != null)
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: InfoDisplayComponent(
                        placeHolder:
                            AppLocalizations.of(context)!.industriesSlashJobs,
                        value:
                            "${AppLocalizations.of(context)!.industries} ${up.appUser!.worker!.industryIds != null ? up.appUser!.worker!.industryIds!.join(", ") : ""}\n\n${AppLocalizations.of(context)!.jobs}: ${up.appUser!.worker!.jobIds != null ? up.appUser!.worker!.jobIds!.join(", ") : ""}",
                        icon: GestureDetector(
                          onTap: () {
                            print("Edit clicked");
                            showDialog(
                              context: context,
                              builder: (context) => ProfileDialog(
                                  child: IndustryJobsDropdownComponent(
                                initialIndustries:
                                    up.appUser!.worker!.industryIds ?? [],
                                initialJobs: up.appUser!.worker!.jobIds ?? [],
                                onPressUpdate:
                                    (selectedIndustries, selectedJobs) async {
                                  print(selectedIndustries);
                                  if (up.appUser!.worker != null) {
                                    up.appUser!.worker!.industryIds =
                                        selectedIndustries;
                                    up.appUser!.worker!.jobIds = selectedJobs;
                                    up.updateWorkerInfo(up.appUser!.worker!);
                                  }
                                  Navigator.of(context).pop();
                                },
                              )),
                            );
                          },
                          child: Icon(
                            UniconsLine.pen,
                            color: Colors.grey[700],
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  const ProfileDivider(),
                  ProfileSection(
                    heading: AppLocalizations.of(context)!.pdfResume,
                    menuIcon: UniconsLine.file_plus,
                    icon: UniconsLine.file_upload,
                    showBasicInfo: showPdfResume,
                    onClickSection: () {
                      print("Section clicked");
                      setState(() {
                        showPdfResume = !showPdfResume;
                      });
                    },
                    onClickEdit: () async {
                      String? pdfUrl = await up.onTapPdf("/pdf-resume/");
                      if (up.appUser!.worker != null && pdfUrl != "") {
                        up.appUser!.worker!.pdfResumeUrl = pdfUrl!;
                        await up.updateWorkerInfo(up.appUser!.worker!);
                      }
                      print("Edit clicked");
                    },
                  ),
                  if (showPdfResume)
                    GestureDetector(
                      onTap: () async {
                        String pdfResumeUrl = up.appUser!.worker!.pdfResumeUrl!;
                        if (pdfResumeUrl.toString().isEmpty) {
                          return;
                        }
                        print('pdfResumeUrl');
                        print(pdfResumeUrl);
                        // File? file = await viewPdf(pdfResumeUrl);
                        //if (file != null) {
                        // Uint8List bytes = await file.readAsBytes();
                        Navigator.of(context).pushNamed("/pdfViewScreen",
                            arguments: {"remotePDFpath": pdfResumeUrl});
                        // }
                        print('Show PDF File');
                        //  print(file);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(12),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        decoration: BoxDecoration(
                            // color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(color: ThemeColors.grey2ThemeColor)),
                        // child: Text("My Resume.pdf"),
                        child:
                            up.appUser!.worker!.pdfResumeUrl!.toString().isEmpty
                                ? IconText404(
                                    icon: UniconsLine.file_times,
                                    text: AppLocalizations.of(context)!
                                        .youHaveNotUploadedAPDFResume,
                                  )
                                : IconText404(
                                    icon: UniconsLine.file,
                                    text: AppLocalizations.of(context)!
                                        .clickHereToViewYourPDFResume,
                                  ),
                      ),
                    ),
                  const ProfileDivider(),
                  ProfileSection(
                    heading: AppLocalizations.of(context)!.onlineResume,
                    menuIcon: UniconsLine.cloud_bookmark,
                    icon: UniconsLine.arrow_right,
                    showInfoInNewPage: true,
                    onClickSection: () {
                      print("Section clicked/ Edit Clicked");
                      if (up.appUser!.worker != null) {
                        context.go("/onlineResumeScreen");
                      }
                    },
                  ),
                  const ProfileDivider(),
                  ProfileSection(
                    heading: AppLocalizations.of(context)!.subscriptions,
                    menuIcon: UniconsLine.user_plus,
                    icon: UniconsLine.arrow_right,
                    showInfoInNewPage: true,
                    onClickSection: () {
                      print("Section clicked/ Edit Clicked");
                      if (up.appUser!.worker != null) {
                        context.go("/payment");
                      }
                    },
                  ),
                  const ProfileDivider(),
                  ProfileSection(
                    heading: AppLocalizations.of(context)!.orders,
                    menuIcon: UniconsLine.receipt_alt,
                    icon: UniconsLine.arrow_right,
                    showInfoInNewPage: true,
                    onClickSection: () {
                      if (up.appUser!.worker != null) {
                        context.go("/orders");
                      }
                    },
                  ),
                  const ProfileDivider(),
                  ProfileSection(
                    heading: AppLocalizations.of(context)!.deleteAccount,
                    menuIcon: UniconsLine.user_times,
                    icon: UniconsLine.trash_alt,
                    showInfoInNewPage: true,
                    onClickSection: () {
                      print("Section clicked/ Edit Clicked");
                      if (up.appUser != null) {
                        print("delete user");

                        chatProvider.clearGroups();
                        up.deleteUser(up.appUser!.uid);

                        showDialog(
                          context: context,
                          builder: (context) => ProfileDialog(
                              child: Column(
                            children: [
                              Text(
                                "Are you sure you want to delete your account?",
                                style:
                                    ThemeTextStyles.headingThemeTextStyle.apply(
                                  color: ThemeColors.blukersOrangeThemeColor,
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                "All your account information will be deleted, this action cannot be undone.",
                                style: ThemeTextStyles.bodyThemeTextStyle,
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      Navigator.of(context).pop();
                                      up.deleteUser(up.appUser!.uid);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: ThemeColors.primaryThemeColor,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        "Delete",
                                        style: ThemeTextStyles
                                            .informationDisplayPlaceHolderThemeTextStyle
                                            .apply(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          chatProvider.clearGroups();
                          await up.signOut();
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil("/", (route) => false);
                        },
                        child: Container(
                          // margin: const EdgeInsets.all(12),
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 24,
                          ),
                          width: width * .90,
                          decoration: BoxDecoration(
                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.red, width: 2),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.logout,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                UniconsLine.sign_out_alt,
                                size: 40,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  AppVersionDisplay(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
    );
  }
}
