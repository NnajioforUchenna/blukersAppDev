import 'package:bulkers/models/worker.dart';
import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/utils/styles/theme_colors.dart';
import 'package:bulkers/utils/styles/theme_text_styles.dart';
import 'package:bulkers/views/common_views/profile_dialog.dart';
import 'package:bulkers/views/common_views/profile_section.dart';

import 'package:bulkers/views/common_views/components/index.dart';
import 'package:bulkers/views/company/profile_components/edit_basic_profile.dart';
import 'package:bulkers/views/company/profile_components/user_basic_profile_details.dart';

import 'package:bulkers/views/worker/create_worker_profile_component/edit_worker_basic_profile.dart';
import 'package:bulkers/views/worker/create_worker_profile_component/worker_basic_profile_detail.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:unicons/unicons.dart';

class OnlineResumeScreen extends StatefulWidget {
  const OnlineResumeScreen({super.key});

  @override
  State<OnlineResumeScreen> createState() => _OnlineResumeScreenState();
}

class _OnlineResumeScreenState extends State<OnlineResumeScreen> {
  bool showBasicInfo = false;

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    Worker worker = up.appUser!.worker!;
    return Scaffold(
      appBar: MyAppBar(
        title: "Online Resume",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Text(
            //   "Profile",
            //   style: ThemeTextStyles.headingThemeTextStyle
            //       .apply(color: Colors.black),
            // ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: worker.profilePhotoUrl != null &&
                            worker.profilePhotoUrl != ""
                        ? FadeInImage.assetNetwork(
                            placeholder: "assets/images/loading.jpeg",
                            image: worker.profilePhotoUrl!,
                            //width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/images/userDefaultProfilePic.png"),
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const SizedBox(height: 30),
                                  Text(
                                    'Change Avatar',
                                    style:
                                        ThemeTextStyles.headingThemeTextStyle,
                                  ),
                                  // const SizedBox(height: 20),
                                  if(!kIsWeb)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 18, vertical: 18),
                                    child: Container(
                                      //  height: 170,
                                      width: 500,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xffF3ECFF),
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              String? imageUrl =
                                                  await up.ontapCamera(
                                                      "/onlineResume/ProfilePics");
                                              if (imageUrl != "") {
                                                worker.profilePhotoUrl =
                                                    imageUrl!;
                                                await up
                                                    .updateWorkerInfo(worker);
                                              }
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 100,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                color: ThemeColors
                                                    .blukersBlueThemeColor,
                                                borderRadius:
                                                    BorderRadius.circular(80),
                                              ),
                                              child: const Icon(
                                                Icons.camera_alt,
                                                size: 40,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Take photo",
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
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              String? imageUrl =
                                                  await up.ontapGallery(
                                                      "/onlineResume/ProfilePics");
                                              if (imageUrl != "") {
                                                worker.profilePhotoUrl =
                                                    imageUrl!;
                                                await up
                                                    .updateWorkerInfo(worker);
                                              }
                                              Navigator.of(context).pop();
                                              print(imageUrl);
                                            },
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 100,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                color: ThemeColors
                                                    .blukersBlueThemeColor,
                                                borderRadius:
                                                    BorderRadius.circular(80),
                                              ),
                                              child: const Image(
                                                image: AssetImage(
                                                    "assets/images/galleryImage.png"),
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "Form gallery",
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
              up.appUser!.displayName ?? "My Profile",
              style: ThemeTextStyles.landingPageSubtitleThemeTextStyle
                  .apply(color: Colors.black),
            ),
            const SizedBox(
              height: 30,
            ),
            ProfileSection(
              heading: "Basic Information",
              icon: Icons.edit_outlined,
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
                  builder: (context) =>const  ProfileDialog(
                    child: EditWorkerBasicProfile(),
                  ),
                );
              },
            ),
            if (showBasicInfo)
              Padding(
                padding: const EdgeInsets.all(16),
                child: WorkerBasicProfileDetail(
                  firstName: worker.firstName,
                  lastName: worker.lastName,
                  middleName: worker.middleName ?? "Not Available",
                  description: worker.workerBriefDescription ?? "Not Available",
                ),
              ),
            ProfileSection(
              heading: "References",
              icon: UniconsLine.arrow_right,
              showInfoInNewPage: true,
              onClickSection: () {
                print("Section clicked/ Edit Clicked");
                if (up.appUser!.worker != null) {
                  Navigator.pushNamed(
                      context, "/onlineResumeAdditionalDetailScreen",
                      arguments: {"isReference": true});
                }
              },
            ),
            ProfileSection(
              heading: "Work Experience",
              icon: UniconsLine.arrow_right,
              showInfoInNewPage: true,
              onClickSection: () {
                print("Section clicked/ Edit Clicked");
                if (up.appUser!.worker != null) {
                  Navigator.pushNamed(
                      context, "/onlineResumeAdditionalDetailScreen",
                      arguments: {"isReference": false});
                }
              },
            ),
            // Positioned(
            //   bottom: 10,
            //   right: 10,
            //   child: Container(
            //     child: Text("Logout"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
