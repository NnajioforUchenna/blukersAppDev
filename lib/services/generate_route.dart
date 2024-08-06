import 'package:blukers/views/common_vieiws/landing_page/landing_page.dart';
import 'package:blukers/views/company/company_chat/mobile_company_chat/chat_screen.dart';
import 'package:blukers/views/company/company_path/company_path.dart';
import 'package:blukers/views/company/workers_home/worker_home_mobile/set_worker_preferences.dart';
import 'package:blukers/views/worker/worker_messages/worker_messages.dart';
import 'package:blukers/views/worker/workers_path/worker_path.dart';
import 'package:blukers/views/worker/workers_path/worker_paths_components/worker_job_preference_path.dart';
import 'package:go_router/go_router.dart';

import '../models/payment_model/url_info.dart';
import '../providers/payment_providers/payments_provider.dart';
import '../views/auth/login/login.dart';
import '../views/auth/registration/registration.dart';
import '../views/auth/reset_password.dart';
import '../views/company/company_chat/company_chat.dart';
import '../views/company/company_messages/company_messages.dart';
import '../views/company/company_offers/company_offers.dart';
import '../views/company/company_page_template/company_page_template.dart';
import '../views/company/company_profile/company_profile.dart';
import '../views/company/create_company_profile/create_company_profile.dart';
import '../views/company/create_job_post/create_job_post.dart';
import '../views/company/display_workers/display_workers.dart';
import '../views/company/my_job_posts/my_job_posts.dart';
import '../views/company/my_job_posts/my_job_posts_components/applicants/applicants.dart';
import '../views/company/search_workers/search_workers_ui.dart';
import '../views/company/search_workers/workers_search_result_page/workers_search_result_page.dart';
import '../views/company/workers_home/worker_home_desktop/set_worker_preferences_desktop.dart';
import '../views/company/workers_home/worker_home_desktop/show_workers_by_preferences_desktop.dart';
import '../views/company/workers_home/worker_home_mobile/show_workers_by_preferences.dart';
import '../views/company/workers_home/workers_home.dart';
import '../views/worker/create_worker_profile/create_worker_profile.dart';
import '../views/worker/create_worker_profile/create_worker_profile_components/pdf_view_screen.dart';
import '../views/worker/create_worker_profile/create_worker_profile_components/resume/online_resume_additional_detail_screen.dart';
import '../views/worker/create_worker_profile/create_worker_profile_components/resume/online_resume_screen.dart';
import '../views/worker/jobs_home/Components/display_jobs_by_preferences/Components/set_jobs_preferences.dart';
import '../views/worker/jobs_home/Components/display_jobs_by_preferences/Components/set_jobs_preferences_desktop.dart';
import '../views/worker/jobs_home/Components/display_jobs_by_preferences/Components/show_jobs_by_preferences.dart';
import '../views/worker/jobs_home/Components/display_jobs_by_preferences/Components/show_jobs_by_preferences_desktop.dart';
import '../views/worker/jobs_home/Components/jobs_mobile_view/select_or_search_jobs.dart';
import '../views/worker/jobs_home/jobs_home.dart';
import '../views/worker/my_jobs/my_jobs.dart';
import '../views/worker/search_jobs/jobs_search_result_page/job_search_result_page.dart';
import '../views/worker/search_jobs/search_jobs_ui.dart';
import '../views/worker/services/services_components/orders/orders_list.dart';
import '../views/worker/services/services_components/products/products.dart';
import '../views/worker/services/services_components/subscription/subscription.dart';
import '../views/worker/services/services_components/subscription/subscription_components/manage_subscription/payment_failed_widget.dart';
import '../views/worker/services/services_components/subscription/subscription_components/manage_subscription/payment_successful_widget.dart';
import '../views/worker/services/services_components/subscription/subscription_components/show_subscription_dialog.dart';
import '../views/worker/services/services_list.dart';
import '../views/worker/worker_chat/chat_message_screen.dart';
import '../views/worker/worker_chat/components/worker_chat_room.dart';
import '../views/worker/worker_chat/worker_chat_platforms.dart';
import '../views/worker/worker_page_template/worker_page_template.dart';
import '../views/worker/worker_profile/worker_profile.dart';
import 'authentication_wrapper.dart';

final goRouter = GoRouter(routes: routes, initialLocation: '/');

final routes = [
  GoRoute(
      path: '/',
      builder: (context, state) => const LandingPage()), // const LandingPage()
  GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthenticationWrapper()),

  // Routes with PageTemplate as Parent:
  ShellRoute(
    builder: (context, state, child) {
      return WorkerPageTemplate(
        child: child,
      );
    },
    routes: [
      GoRoute(path: '/jobs', builder: (context, state) => const Jobs()),
      GoRoute(
          path: '/selectJobs',
          builder: (context, state) => const SelectOrSearchJobs()),
      GoRoute(
          path: '/searchJobs',
          builder: (context, state) => const SearchJobsUi()),
      GoRoute(
          path: '/workerChat',
          builder: (context, state) => const WorkerChatPlatforms()),
      GoRoute(path: '/myJobs', builder: (context, state) => const MyJobs()),
      GoRoute(
          path: '/jobSearchResults',
          builder: (context, state) => const JobSearchResultPage()),
      GoRoute(
          path: '/workerProfile',
          builder: (context, state) => const WorkerProfile()),
      GoRoute(
          path: '/workerOffers',
          builder: (context, state) => const ServicesList()),
      GoRoute(path: '/pathToJob', builder: (context, state) => WorkerPath()),
      GoRoute(
          path: '/jobPreference',
          builder: (context, state) => const JobPreferncePath()),
      GoRoute(
          path: '/showJobsByPreferences',
          builder: (context, state) => const ShowJobsByPreferences()),
      GoRoute(
        path: '/setJobsPreferences',
        builder: (context, state) => const SetJobsPreferences(),
      ),
      GoRoute(
          path: '/showJobsByPreferencesDesktop',
          builder: (context, state) => const ShowJobsByPreferencesDesktop()),
      GoRoute(
        path: '/setJobsPreferencesDesktop',
        builder: (context, state) => const SetJobsPreferencesDesktop(),
      ),
      GoRoute(
          path: '/workerMessages',
          builder: (context, state) => const WorkerMessages()),
    ],
  ),

  ShellRoute(
    builder: (context, state, child) {
      return CompanyPageTemplate(
        child: child,
      );
    },
    routes: [
      // Company Routes

      GoRoute(path: '/workers', builder: (context, state) => const Workers()),
      GoRoute(
          path: '/companyOffers',
          builder: (context, state) => const CompanyOffers()),
      GoRoute(
          path: '/searchWorkers',
          builder: (context, state) => const SearchWorkersUi()),
      GoRoute(
          path: '/workerSearchResults',
          builder: (context, state) => const WorkerSearchResultPage()),
      GoRoute(
          path: '/myJobPosts', builder: (context, state) => const MyJobPosts()),
      GoRoute(
          path: '/companyProfile',
          builder: (context, state) => const CompanyProfile()),
      GoRoute(
          path: '/companyChat',
          builder: (context, state) => const CompanyChat()),
      GoRoute(
          path: '/pathToEmployingWorker',
          builder: (context, state) => CompanyPath()),
      GoRoute(
          path: '/companyMessages',
          builder: (context, state) => const CompanyMessages()),

      GoRoute(
          path: '/displayWorkers',
          builder: (context, state) => const DisplayWorkers()),

      GoRoute(
          path: '/setWorkersPreferences',
          builder: (context, state) => const SetWorkersPreferences()),
      GoRoute(
          path: '/setWorkersPreferencesDesktop',
          builder: (context, state) => const DesktopSetWorkersPreferences()),
      GoRoute(
          path: '/showWorkersByPreferences',
          builder: (context, state) => const ShowWorkersByPreferences()),
      GoRoute(
          path: '/showWorkersByPreferencesDesktop',
          builder: (context, state) => const DesktopShowWorkersByPreferences()),
    ],
  ),

  GoRoute(
      path: '/createResume',
      builder: (context, state) => const CreateWorkerProfile()),

  GoRoute(
      path: '/company-worker_chat',
      builder: (context, state) => const CompanyChat()),

  GoRoute(
      path: '/workerChatRoom',
      builder: (context, state) => const WorkerChatRoom()),

  GoRoute(
      path: '/companyChatRoomScreen',
      builder: (context, state) => const CompanyChatRoomScreen()),

  GoRoute(
      path: '/worker_chat-message',
      builder: (context, state) => const ChatMessageScreen()),

  // Profile Routes
  GoRoute(
      path: '/onlineResumeScreen',
      builder: (context, state) => const OnlineResumeScreen()),
  GoRoute(
    path: '/onlineResumeAdditionalDetailScreen',
    builder: (context, state) {
      Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
      return OnlineResumeAdditionalDetailScreen(
          isReference: extra['isReference']);
    },
  ),
  GoRoute(
      path: '/pdfViewScreen',
      builder: (context, state) => const ResumeScreen()),

  // Payments Routes

  GoRoute(path: '/payment', builder: (context, state) => const Subscription()),
  GoRoute(
      path: '/paymentFailed',
      builder: (context, state) {
        verifyCurrentPath();
        return const PaymentFailedWidget();
      }),
  GoRoute(
      path: '/paymentFailed/:sessionId',
      builder: (context, state) {
        verifyCurrentPath();
        return const PaymentFailedWidget();
      }),
  GoRoute(
      path: '/paymentSuccess',
      builder: (context, state) {
        verifyCurrentPath();
        return const PaymentSuccessfulWidget();
      }),
  GoRoute(
      path: '/paymentSuccess/:sessionId',
      builder: (context, state) {
        verifyCurrentPath();
        return const PaymentSuccessfulWidget();
      }),

  // Auth Routes

  GoRoute(path: '/login', builder: (context, state) => const Login()),
  GoRoute(path: '/register', builder: (context, state) => const Registration()),
  GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ResetPasswordPage()),

  // JobPost Routes
  GoRoute(
      path: '/createJobPost',
      builder: (context, state) => const CreateJobPost()),
  GoRoute(
      path: '/createWorkerProfile',
      builder: (context, state) => const CreateWorkerProfile()),
  GoRoute(path: '/applicants', builder: (context, state) => const Applicants()),
  GoRoute(
      path: '/createCompanyProfile',
      builder: (context, state) => const CreateCompanyProfile()),

  // Services Routes
  GoRoute(
      path: '/membership',
      builder: (context, state) => const ShowSubscriptionDialog()),
  GoRoute(
      path: '/selectMembership',
      builder: (context, state) => const Subscription()),
  GoRoute(path: '/services', builder: (context, state) => const Products()),

  GoRoute(path: '/orders', builder: (context, state) => const OrdersList()),
];

void verifyCurrentPath() {
  PaymentsProvider pp = PaymentsProvider();
  String urlEx = Uri.base.toString();
  UrlInfo urlInfo = UrlInfo.parseUrl(urlEx);
  if (urlInfo.sessionId != null) {
    pp.verifyPayment(urlInfo, 'success');
  }
}
