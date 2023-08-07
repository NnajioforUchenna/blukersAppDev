import 'package:bulkers/views/chat_message_screen.dart';
import 'package:bulkers/views/company/company_basic_info.dart';
import 'package:bulkers/views/company_chat.dart';
import 'package:flutter/material.dart';

import '../views/auth/login.dart';
import '../views/auth/registration_process.dart';
import '../views/auth/reset_password.dart';
import '../views/common_views/landing_page_components/landing_page.dart';
import '../views/company/company_profile.dart';
import '../views/company/my_job_posts.dart';
import '../views/company/my_job_posts_components/create_job_post_components/create_job_post.dart';
import '../views/company/workers.dart';
import '../views/worker/create_worker_profile_component/create_worker_profile.dart';
import '../views/worker/jobs.dart';
import '../views/worker/my_jobs.dart';
import '../views/worker/worker_profile.dart';

MaterialPageRoute generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(
          builder: (context) =>  LandingPage());
    case '/workers':
      return MaterialPageRoute(builder: (context) => const Workers());
    case '/jobs':
      return MaterialPageRoute(builder: (context) => const Jobs());
    case '/myJobs':
      return MaterialPageRoute(builder: (context) => const MyJobs());
    case '/myJobPosts':
      return MaterialPageRoute(builder: (context) => const MyJobPosts());
      case '/companyBasicInfo':
      return MaterialPageRoute(builder: (context) => const CompanyBasicInfo());
    case '/workerProfile':
      return MaterialPageRoute(builder: (context) => const WorkerProfile());
    case '/companyChat':
      return MaterialPageRoute(builder: (context) => const CompanyChat());
    case 'companyProfile':
      return MaterialPageRoute(builder: (context) => const CompanyProfile());
    case '/login':
      return MaterialPageRoute(builder: (context) => const Login());
    case '/register':
      return MaterialPageRoute(builder: (context) => RegistrationProcess());
    case '/forgot-password':
      return MaterialPageRoute(builder: (context) => ResetPasswordPage());
    case '/createJobPost':
      return MaterialPageRoute(builder: (context) => const CreateJobPost());
    case '/createWorkerProfile':
      return MaterialPageRoute(
          builder: (context) => const CreateWorkerProfile());
    case '/company-chat':
      return MaterialPageRoute(builder: (context) => const CompanyChat());
    case '/chat-message':
      return MaterialPageRoute(
          builder: (context) => ChatMessageScreen(settings.arguments),
          settings: settings);
    default:
      return MaterialPageRoute(builder: (context) => LandingPage());
  }
}
