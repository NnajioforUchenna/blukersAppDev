import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/job_post.dart';
import '../../../../providers/job_posts_provider.dart';
import '../../../../services/responsive.dart';
import '../../jobs_home/job_home_components/jobs_desktop_view/jobs_desktop_view_components/select_desktop_language_dialog.dart';
import '../../jobs_home/job_home_components/jobs_mobile_view/jobs_mobile_view_compnents/search_and_translate_row.dart';
import '../job_search_bar_components/job_all_search_bar.dart';
import 'Components/complete_job_posts_widget.dart';

class JobSearchResultPage extends StatelessWidget {
  const JobSearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    List<JobPost> jobPosts = jp.displayedJobPosts.values.toList();
    return SingleChildScrollView(
      child: Column(
        children: [
          if (Responsive.isMobile(context)) ...[
            const SearchAndTranslateRow(),
          ] else ...[
            const JobAllSearchBar(),
            const SizedBox(height: 10),
            const Center(child: SelectDesktopLanguageDialog()),
            const SizedBox(height: 10),
            const Divider(),
          ],
          CompleteJobPostWidget(jobPosts: jobPosts),
        ],
      ),
    );
  }
}
