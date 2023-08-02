import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/job_posts_provider.dart';
import '../../providers/user_provider.dart';
import '../common_views/page_template/page_template.dart';
import 'my_jobs_components/applied_jobs.dart';
import 'my_jobs_components/saved_jobs.dart';

class MyJobs extends StatelessWidget {
  const MyJobs({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    JobPostsProvider jpp = Provider.of<JobPostsProvider>(context);
    return PageTemplate(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Worker Dashboard'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Applied Jobs'),
                Tab(text: 'Saved Jobs'),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              AppliedJobs(),
              SavedJobs(),
            ],
          ),
        ),
      ),
    );
  }
}
