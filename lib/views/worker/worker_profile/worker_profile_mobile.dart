import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_eight/profile_row_eight.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_five/profile_row_five.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_four/profile_row_four.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_nine/profile_row_nine.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_one/profile_row_one.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_seven/profile_row_seven.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_six/profile_row_six.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_ten/profile_row_ten.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_three/profile_row_three.dart';
import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_two/profile_row_two.dart';
import 'package:flutter/material.dart';

import '../../old_common_views/components/app_version_display.dart';

class WorkerProfileMobile extends StatelessWidget {
  const WorkerProfileMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         // ProfileRowOne(),
          SizedBox(height: 50),
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
          ProfileRowTen(),
          SizedBox(height: 20),
          AppVersionDisplay(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
