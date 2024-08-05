import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/company/create_job_post/creat_job_post_mobile.dart';
import 'package:blukers/views/company/create_job_post/create_job_post_web.dart';
import 'package:flutter/material.dart';

class CreateJobPost extends StatelessWidget {
  const CreateJobPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? const CreateJobPostWeb()
        : const CreateJobPostMobile();
  }
}
