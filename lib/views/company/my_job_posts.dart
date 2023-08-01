import 'package:bulkers/services/responsive.dart';
import 'package:bulkers/views/common_views/page_template/page_template.dart';
import 'package:flutter/material.dart';

import 'my_job_posts_components/interesting_workers_tab.dart';
import 'my_job_posts_components/my_job_posts_tab.dart';

class MyJobPosts extends StatelessWidget {
  const MyJobPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Company Dashboard'),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Interesting Workers'),
                Tab(text: 'My Job Posts'),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add), // Use Icon instead of IconButton
                      if (Responsive.isDesktop(context))
                        const Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Text('Add Job Post'),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: const TabBarView(
            children: [
              InterestingWorkersTab(),
              MyJobPostsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
