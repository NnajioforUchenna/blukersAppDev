import 'package:blukers/views/company/comapny_profile/company_profile_rows/profile_row_five/profile_row_five.dart';
import 'package:blukers/views/company/comapny_profile/company_profile_rows/profile_row_four/profile_row_four.dart';
import 'package:blukers/views/company/comapny_profile/company_profile_rows/profile_row_one/profile_row_one.dart';
import 'package:blukers/views/company/comapny_profile/company_profile_rows/profile_row_six/profile_row_six.dart';
import 'package:blukers/views/company/comapny_profile/company_profile_rows/profile_row_three/profile_row_three.dart';
import 'package:blukers/views/company/comapny_profile/company_profile_rows/profile_row_two/profile_row_two.dart';
import 'package:blukers/views/old_common_views/components/app_version_display.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../providers/app_settings_provider.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import '../../auth/common_widget/login_or_register.dart';
import '../../common_vieiws/page_template/page_template.dart';

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
    AppSettingsProvider avp = Provider.of<AppSettingsProvider>(context);

    if (!kIsWeb) {
      avp.checkForUpdate(context);
    }

    return PageTemplate(
      child: up.appUser == null
          ? const LoginOrRegister()
          : const SingleChildScrollView(
              child: Column(
                children: [
                  CompanyProfileRowOne(),
                  CompanyProfileRowTwo(),
                  CompanyProfileRowThree(),
                  CompanyProfileRowFour(),
                  SizedBox(height: 20),
                  CompanyProfileRowFive(),
                  SizedBox(height: 20),
                  CompanyProfileRowSix(),
                  SizedBox(height: 40),
                  AppVersionDisplay(),
                ],
              ),
            ),
    );
  }
}
