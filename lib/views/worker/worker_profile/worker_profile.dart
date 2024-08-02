// import 'dart:io';
import 'package:blukers/providers/app_settings_provider.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_one/profile_row_one.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_two/profile_row_two.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import '../../auth/common_widget/login_or_register.dart';
import '../../old_common_views/components/app_version_display.dart';
import 'profile_rows/profile_row_eight/profile_row_eight.dart';
import 'profile_rows/profile_row_five/profile_row_five.dart';
import 'profile_rows/profile_row_four/profile_row_four.dart';
import 'profile_rows/profile_row_nine/profile_row_nine.dart';
import 'profile_rows/profile_row_seven/profile_row_seven.dart';
import 'profile_rows/profile_row_six/profile_row_six.dart';
import 'profile_rows/profile_row_three/profile_row_three.dart';

class WorkerProfile extends StatefulWidget {
  const WorkerProfile({super.key});

  @override
  State<WorkerProfile> createState() => _WorkerProfileState();
}

class _WorkerProfileState extends State<WorkerProfile> {
  bool showBasicInfo = false;
  bool showIndustries = false;
  bool showPdfResume = false;

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    AppSettingsProvider avp = Provider.of<AppSettingsProvider>(context);

    if (!kIsWeb) {
      avp.checkForUpdate(context);
    }

    return up.appUser == null
        ? const LoginOrRegister()
        : const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileRowOne(),
                ProfileRowTwo(),
                ProfileRowThree(),
                ProfileRowFour(),
                SizedBox(height: 10),
                ProfileRowFive(),
                SizedBox(height: 10),
                ProfileRowSix(),
                SizedBox(height: 10),
                ProfileRowSeven(),
                SizedBox(height: 10),
                ProfileRowEight(),
                SizedBox(height: 10),
                ProfileRowNine(),
                SizedBox(height: 20),
                AppVersionDisplay(),
                SizedBox(height: 20),
              ],
            ),
          );
  }
}
