import 'package:bulkers/views/chat_message_screen.dart';
import 'package:bulkers/views/company/company_basic_info.dart';
import 'package:bulkers/views/company_chat.dart';
import 'package:bulkers/views/worker/create_worker_profile_component/online_resume_additional_detail_screen.dart';
import 'package:bulkers/views/worker/online_resume_screen.dart';
import 'package:bulkers/views/worker/pdf_view_screen.dart';
import 'package:flutter/material.dart';

import '../views/auth/login.dart';
import '../views/auth/registration_process.dart';
import '../views/auth/reset_password.dart';
import '../views/company/company_profile.dart';
import '../views/company/create_company_profile/create_company_profile.dart';
import '../views/company/my_job_posts.dart';
import '../views/company/my_job_posts_components/applicants/applicants.dart';
import '../views/company/my_job_posts_components/create_job_post_components/create_job_post.dart';
import '../views/company/workers.dart';
import '../views/worker/create_worker_profile_component/create_worker_profile.dart';
import '../views/worker/jobs.dart';
import '../views/worker/my_jobs.dart';
import '../views/worker/worker_profile.dart';
import 'authentication_wrapper.dart';

MaterialPageRoute generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      // return MaterialPageRoute(builder: (context) => LandingPage());
      return MaterialPageRoute(
          builder: (context) => const AuthenticationWrapper());
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
    case '/onlineResumeScreen':
      return MaterialPageRoute(
          builder: (context) => const OnlineResumeScreen());
    case '/onlineResumeAdditionalDetailScreen':
      return MaterialPageRoute(
          builder: (context) => const OnlineResumeAdditionalDetailScreen(),
          settings: settings);
    case '/pdfViewScreen':
      return MaterialPageRoute(
          builder: (context) => const ResumeScreen(), settings: settings);
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
    case '/applicants':
      return MaterialPageRoute(builder: (context) => const Applicants());
    case '/createCompanyProfile':
      return MaterialPageRoute(
          builder: (context) => const CreateCompanyProfile());
    case '/company-chat':
      return MaterialPageRoute(builder: (context) => const CompanyChat());
    case '/chat-message':
      return MaterialPageRoute(
          builder: (context) => const ChatMessageScreen(), settings: settings);
    default:
      return MaterialPageRoute(
          builder: (context) => const AuthenticationWrapper());
    // return MaterialPageRoute(builder: (context) => const CompanyChat());
  }
}
