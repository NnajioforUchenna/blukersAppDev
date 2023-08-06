import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/utils/styles/theme_text_styles.dart';
import 'package:bulkers/views/auth/common_widget/login_or_register.dart';
import 'package:bulkers/views/common_views/profile_dialog.dart';
import 'package:bulkers/views/common_views/profile_section.dart';
import 'package:bulkers/views/company/profile_components/basic_profile_details.dart';
import 'package:bulkers/views/company/profile_components/edit_basic_profile.dart';
import 'package:bulkers/views/company/workers_components/display_worker_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common_views/page_template/page_template.dart';

class CompanyProfile extends StatelessWidget {
  const CompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return PageTemplate(
        child: up.appUser == null
            ? LoginOrRegister()
            : Column(
                children: [
                  Text(
                    "Profile",
                    style: ThemeTextStyles.headingThemeTextStyle
                        .apply(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                    onClickSection: () {
                      print("Section clicked");
                      showDialog(
                        context: context,
                        builder: (context) => ProfileDialog(
                          child: BasicProfileDetail(
                            displayName:
                                up.appUser!.displayName ?? "Not Available",
                            email: up.appUser!.email ?? "Not Available",
                            phoneNo: up.appUser!.phoneNumber ?? "Not Available",
                            language: up.appUser!.language ?? "Not Available",
                          ),
                        ),
                      );
                    },
                    onClickEdit: () {
                      print("Edit clicked");
                      showDialog(
                        context: context,
                        builder: (context) => ProfileDialog(
                          child: EditBasicProfile(
                            displayName:
                                up.appUser!.displayName ?? "",
                            phoneNo: up.appUser!.phoneNumber ?? "",
                            language: up.appUser!.language ?? "",
                          ),
                        ),
                      );
                    },
                  ),
                  ProfileSection(
                    heading: "Company Information",
                    icon: Icons.arrow_forward_ios,
                    onClickSection: () {
                      print("Section clicked/ Edit Clicked");
                    },
                  ),
                ],
              ));
  }
}
