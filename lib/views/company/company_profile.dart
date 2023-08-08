import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/utils/styles/index.dart';
import 'package:bulkers/utils/styles/theme_text_styles.dart';
import 'package:bulkers/views/auth/common_widget/login_or_register.dart';
import 'package:bulkers/views/common_views/profile_dialog.dart';
import 'package:bulkers/views/common_views/profile_section.dart';
import 'package:bulkers/views/company/profile_components/user_basic_profile_details.dart';
import 'package:bulkers/views/company/profile_components/edit_basic_profile.dart';
import 'package:bulkers/views/company/workers_components/display_worker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_views/page_template/page_template.dart';

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
                  Text(
                    "Profile",
                    style: ThemeTextStyles.headingThemeTextStyle
                        .apply(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: up.appUser!.photoUrl != null &&
                                  up.appUser!.photoUrl != ""
                              ? FadeInImage.assetNetwork(
                                  placeholder: "assets/images/loading.jpeg",
                                  image: up.appUser!.photoUrl!,
                                  //width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset("assets/images/mockImage.png"),
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
                                                        await up.ontapCamera("/profile_images/");
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
                                                        await up.ontapGallery("/profile_images/");
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
                            radius: 15,
                            backgroundColor: ThemeColors.blukersBlueThemeColor,
                            child: Icon(
                              Icons.edit,
                              size: 15,
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
                    icon: Icons.arrow_forward_ios,
                    onClickSection: () {
                      print("Section clicked/ Edit Clicked");
                      if (up.appUser!.company != null) {
                        Navigator.pushNamed(context, "/companyBasicInfo");
                      }
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
