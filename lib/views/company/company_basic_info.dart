import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../models/company.dart';
import '../../providers/user_provider_parts/user_provider.dart';
import '../../utils/styles/theme_colors.dart';
import '../../utils/styles/theme_text_styles.dart';

import '../common_vieiws/policy_terms/policy_terms_components/my_app_bar.dart';
import '../old_common_views/profile_section.dart';
import 'profile_components/company_additional_profile_detail.dart';
import 'profile_components/company_basic_profile_detail.dart';

class CompanyBasicInfo extends StatefulWidget {
  const CompanyBasicInfo({super.key});

  @override
  State<CompanyBasicInfo> createState() => _CompanyBasicInfoState();
}

class _CompanyBasicInfoState extends State<CompanyBasicInfo> {
  bool showBasicInfo = false;
  bool showAdditionalInfo = false;
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    Company company = up.appUser!.company!;
    return Scaffold(
      appBar: MyAppBar(
        title: "Company Profile",
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                    child: company.logoUrl != ""
                        ? FadeInImage.assetNetwork(
                            placeholder: "assets/images/loading.jpeg",
                            image: company.logoUrl,
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
                                  const Text(
                                    'Change Avatar',
                                    style:
                                        ThemeTextStyles.headingThemeTextStyle,
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
                                                      "/company_profile_images/");
                                              if (imageUrl != "") {
                                                company.logoUrl = imageUrl!;
                                                up.updateCompanyInfo(company);
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
                                          const Text(
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
                                                      "/company_profile_images/");
                                              if (imageUrl != "") {
                                                company.logoUrl = imageUrl!;
                                                up.updateCompanyInfo(company);
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
                                          const Text(
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
              company.name,
              style: ThemeTextStyles.landingPageSubtitleThemeTextStyle
                  .apply(color: Colors.black),
            ),
            const SizedBox(
              height: 30,
            ),
            ProfileSection(
              heading: AppLocalizations.of(context)!.basicInformation,
              icon: Icons.edit_outlined,
              showBasicInfo: showBasicInfo,
              showEditIcon: false,
              onClickSection: () {
                print(company);
                setState(() {
                  showBasicInfo = !showBasicInfo;
                });
              },
            ),
            if (showBasicInfo)
              Padding(
                padding: const EdgeInsets.all(16),
                child: CompanyBasicProfileDetail(
                  company: company,
                  onPressUpdate: (company) async {
                    await up.updateCompanyInfo(company);
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ProfileSection(
              heading: "Additional Information",
              icon: Icons.edit_outlined,
              showBasicInfo: showAdditionalInfo,
              showEditIcon: false,
              onClickSection: () {
                // print(company);
                setState(() {
                  showAdditionalInfo = !showAdditionalInfo;
                });
              },
            ),
            if (showAdditionalInfo)
              Padding(
                padding: const EdgeInsets.all(16),
                child: CompanyAdditionalProfileDetail(
                  company: company,
                  onPressUpdate: (company) async {
                    await up.updateCompanyInfo(company);
                    Navigator.of(context).pop();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
