import 'package:blukers/services/responsive.dart';
import 'package:blukers/views/company/create_job_post/creat_job_post_mobile.dart';
import 'package:blukers/views/company/create_job_post/create_job_post_web.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider_parts/user_provider.dart';
import '../../auth/common_widget/login_or_register.dart';
import '../common_widgets/please_create_company_profile.dart';

class CreateJobPost extends StatelessWidget {
  const CreateJobPost({super.key});

  @override
  Widget build(BuildContext context) {
    UserProvider up = Provider.of<UserProvider>(context);
    return up.appUser == null
        ? const LoginOrRegister()
        : up.isUserCompanyProfile()
            ? Responsive.isDesktop(context)
                ? const PleaseCreateCompanyProfile()
                : const CreateJobPostMobile()
            : const PleaseCreateCompanyProfile();
  }
}
// CreateJobPostWeb()