import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/utils/styles/index.dart';
import 'package:bulkers/utils/styles/theme_text_styles.dart';
import 'package:bulkers/views/auth/common_widget/login_or_register.dart';
import 'package:bulkers/views/common_views/profile_dialog.dart';
import 'package:bulkers/views/common_views/profile_section.dart';
import 'package:bulkers/views/company/profile_components/user_basic_profile_details.dart';
import 'package:bulkers/views/company/profile_components/edit_basic_profile.dart';
import 'package:bulkers/views/company/workers_components/display_worker_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_views/page_template/page_template.dart';

import 'package:unicons/unicons.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({super.key});

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  bool showBasicInfo = false;
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return PageTemplate(
      child: up.appUser == null
          ? LoginOrRegister()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await up.signOut();
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil("/", (route) => false);
                        },
                        child: Container(
                          margin: const EdgeInsets.all(12),
                          // padding: const EdgeInsets.symmetric(
                          //     vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(1000)),
                          child: const Icon(
                            UniconsLine.sign_out_alt,
                            size: 60,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "Profile",
                    style: TextStyle(
                      color: ThemeColors.primaryThemeColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(1000),
                        child: Container(
                          // decoration: BoxDecoration(
                          //   color: Colors.red,
                          // ),
                          width: 250,
                          height: 250,
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
                                          'Change Avatar',
                                          style: ThemeTextStyles
                                              .headingThemeTextStyle,
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
                                                    Navigator.of(context).pop();
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
                    up.appUser!.displayName ?? "Display Name",
                    style: ThemeTextStyles.landingPageSubtitleThemeTextStyle
                        .apply(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ProfileSection(
                    heading: "Basic Information",
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
                  ProfileSection(
                    heading: "Company Information",
                    icon: UniconsLine.arrow_right,
                    showInfoInNewPage: true,
                    onClickSection: () {
                      print("Section clicked/ Edit Clicked");
                      if (up.appUser!.company != null) {
                        Navigator.pushNamed(context, "/companyBasicInfo");
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
