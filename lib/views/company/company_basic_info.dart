import 'package:bulkers/models/company.dart';
import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/utils/styles/theme_text_styles.dart';
import 'package:bulkers/views/common_views/profile_dialog.dart';
import 'package:bulkers/views/common_views/profile_section.dart';
import 'package:bulkers/views/company/profile_components/company_basic_profile_detail.dart';
import 'package:bulkers/views/company/profile_components/edit_company_basic_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompanyBasicInfo extends StatefulWidget {
  const CompanyBasicInfo({super.key});

  @override
  State<CompanyBasicInfo> createState() => _CompanyBasicInfoState();
}

class _CompanyBasicInfoState extends State<CompanyBasicInfo> {
  bool showBasicInfo = false;
  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    Company company = up.appUser!.company!;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Company Profile",
          style: ThemeTextStyles.informationDisplayPlaceHolderThemeTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child:
                    up.appUser!.photoUrl != null && up.appUser!.photoUrl != ""
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
              company.name,
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
                  name: company.name,
                  emails: company.emails,
                  phoneNumbers: company.phoneNumbers,
                  addresses: company.addresses,
                  companyDescription: company.companyDescription,
                  onPressEditIcon: () {
                    print("Edit clicked");
                    showDialog(
                      context: context,
                      builder: (context) => ProfileDialog(
                        child: EditCompanyBasicInfo(
                          placeHolder: "Emails",
                          value: company.name,
                          //   values: company.emails,//["+92-317 7936365"],
                          // isPhoneNumber: true,
                        ),
                      ),
                    );
                  },
                ),
              ),
               ProfileSection(
              heading: "Additional Information",
              icon: Icons.edit_outlined,
              showBasicInfo: showBasicInfo,
              showEditIcon: false,
              onClickSection: () {
               // print(company);
                // setState(() {
                //   showBasicInfo = !showBasicInfo;
                // });
              },
            ),
          ],
        ),
      ),
    );
  }
}
