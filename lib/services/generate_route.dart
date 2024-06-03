import 'package:blukers/views/common_vieiws/all_search_bar_components/company_search_page.dart';
import 'package:blukers/views/common_vieiws/all_search_bar_components/worker_search_page.dart';
import 'package:go_router/go_router.dart';

import '../models/payment_model/url_info.dart';
import '../providers/payment_providers/payments_provider.dart';
import '../views/auth/login/login.dart';
import '../views/auth/registration/registration.dart';
import '../views/auth/reset_password.dart';
import '../views/common_vieiws/landing_page/landing_page.dart';
import '../views/company/comapny_profile/company_profile.dart';
import '../views/company/company_basic_info.dart';
import '../views/company/company_chat.dart';
import '../views/company/create_company_profile/create_company_profile.dart';
import '../views/company/my_job_posts.dart';
import '../views/company/my_job_posts_components/applicants/applicants.dart';
import '../views/company/my_job_posts_components/create_job_post_components/create_job_post.dart';
import '../views/company/workers.dart';
import '../views/worker/services/services_components/orders/orders_list.dart';
import '../views/worker/services/services_components/products/products.dart';
import '../views/worker/services/services_components/subscription/subscription.dart';
import '../views/worker/services/services_components/subscription/subscription_components/manage_subscription/payment_failed_widget.dart';
import '../views/worker/services/services_components/subscription/subscription_components/manage_subscription/payment_successful_widget.dart';
import '../views/worker/services/services_components/subscription/subscription_components/show_subscription_dialog.dart';
import '../views/worker/services/services_list.dart';
import '../views/worker/worker_chat/chat_message_screen.dart';
import '../views/worker/worker_chat/workerChatRoom.dart';
import '../views/worker/worker_chat/worker_chat.dart';
import '../views/worker/worker_home/my_jobs_and_components/my_jobs.dart';
import '../views/worker/worker_home/worker_home.dart';
import '../views/worker/worker_profile/create_worker_profile/create_worker_profile.dart';
import '../views/worker/worker_profile/create_worker_profile/create_worker_profile_components/pdf_view_screen.dart';
import '../views/worker/worker_profile/create_worker_profile/create_worker_profile_components/resume/online_resume_additional_detail_screen.dart';
import '../views/worker/worker_profile/create_worker_profile/create_worker_profile_components/resume/online_resume_screen.dart';
import '../views/worker/worker_profile/worker_profile.dart';
import 'authentication_wrapper.dart';

final goRouter = GoRouter(routes: routes, initialLocation: '/');

final routes = [
  // GoRoute(path: '/', builder: (context, state) => const TestsScreen()),
  GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthenticationWrapper()), //
  // const AuthenticationWrapper() //  SplashScreen()// GoRoute(
  //     path: '/',
  //     builder: (context, state) =>
  //         const ServicesList()), //AuthenticationWrapper())
  GoRoute(path: '/', builder: (context, state) => const LandingPage()),
  GoRoute(path: '/workers', builder: (context, state) => const Workers()),
  GoRoute(path: '/jobs', builder: (context, state) => const Jobs()),
  GoRoute(path: '/myJobs', builder: (context, state) => const MyJobs()),
  GoRoute(path: '/myJobPosts', builder: (context, state) => const MyJobPosts()),
  GoRoute(
      path: '/companyBasicInfo',
      builder: (context, state) => const CompanyBasicInfo()),
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
  GoRoute(path: '/search', builder: (context, state) => const SearchPage()),
  GoRoute(path: '/companysearch', builder: (context, state) => const CompanySearchPage()),
  GoRoute(
      path: '/pdfViewScreen',
      builder: (context, state) => const ResumeScreen()),
  GoRoute(
      path: '/workerProfile',
      builder: (context, state) => const WorkerProfile()),
  GoRoute(
      path: '/companyChat', builder: (context, state) => const CompanyChat()),
  GoRoute(path: '/workerChat', builder: (context, state) => const WorkerChat()),
  GoRoute(
      path: '/workerChatRoom',
      builder: (context, state) => const WorkerChatRoom()),

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
  GoRoute(
      path: '/companyProfile',
      builder: (context, state) => const CompanyProfile()),
  GoRoute(path: '/login', builder: (context, state) => const Login()),
  GoRoute(path: '/register', builder: (context, state) => const Registration()),
  GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ResetPasswordPage()),
  GoRoute(
      path: '/createJobPost',
      builder: (context, state) => const CreateJobPost()),
  GoRoute(
      path: '/createWorkerProfile',
      builder: (context, state) => const CreateWorkerProfile()),
  GoRoute(path: '/applicants', builder: (context, state) => const Applicants()),
  GoRoute(
      path: '/membership',
      builder: (context, state) => const ShowSubscriptionDialog()),
  GoRoute(
      path: '/selectMembership',
      builder: (context, state) => const Subscription()),

  GoRoute(path: '/services', builder: (context, state) => const Products()),
  GoRoute(path: '/offers', builder: (context, state) => const ServicesList()),
  GoRoute(path: '/orders', builder: (context, state) => const OrdersList()),
  GoRoute(
      path: '/createCompanyProfile',
      builder: (context, state) => const CreateCompanyProfile()),
  GoRoute(
      path: '/company-worker_chat',
      builder: (context, state) => const CompanyChat()),
  GoRoute(
      path: '/worker_chat-message',
      builder: (context, state) => const ChatMessageScreen())
];

void verifyCurrentPath() {
  PaymentsProvider pp = PaymentsProvider();
  String urlEx = Uri.base.toString();
  UrlInfo urlInfo = UrlInfo.parseUrl(urlEx);
  if (urlInfo.sessionId != null) {
    pp.verifyPayment(urlInfo, 'success');
  }
}
