import 'package:blukers/views/company/create_job_post/creat_job_post_mobile.dart';
import 'package:blukers/views/company/create_job_post/create_job_post_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../services/responsive.dart';
import 'create_job_post_components/job_post_page_slider.dart';
import 'create_job_post_components/job_post_time_line.dart';

class CreateJobPost extends StatelessWidget {
  const CreateJobPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isMobile(context)
        ? const CreateJobPostMobile()
        : const CreateJobPostWeb();
  }
}
