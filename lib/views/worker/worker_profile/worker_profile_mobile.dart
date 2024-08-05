import 'package:blukers/views/worker/worker_profile/profile_rows/profile_row_two/profile_row_two.dart';
import 'package:flutter/material.dart';

class WorkerProfileMobile extends StatelessWidget {
  const WorkerProfileMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileRowTwo(),
        ],
      ),
    );
  }
}
