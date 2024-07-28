import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../saved/build_list_view_jobs.dart';
import 'jobs_preferences_card.dart';

class ShowJobsByPreferences extends StatelessWidget {
  const ShowJobsByPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return const SingleChildScrollView(
      child: Column(
        children: [
          JobsPreferencesCard(),
          BuildListViewJobs(),
        ],
      ),
    );
  }
}
