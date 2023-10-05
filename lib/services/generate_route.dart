import 'package:blukers/providers/payment_providers/payments_provider.dart';
import 'package:blukers/views/chat_message_screen.dart';
import 'package:blukers/views/common_views/landing_page_components/landing_page.dart';
import 'package:blukers/views/company/company_basic_info.dart';
import 'package:blukers/views/company_chat.dart';
import 'package:blukers/views/worker/create_worker_profile_component/online_resume_additional_detail_screen.dart';
import 'package:blukers/views/worker/online_resume_screen.dart';
import 'package:blukers/views/worker/pdf_view_screen.dart';
import 'package:go_router/go_router.dart';

import '../models/payment_model/url_info.dart';
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
import '../views/worker/jobs_and_componets/jobs.dart';
import '../views/worker/membership/membership_widget.dart';
import '../views/worker/membership/mobile_view/manage_payment_page.dart';
import '../views/worker/membership/show_subscription_dialog.dart';
import '../views/worker/membership/subscription_components/payment_failed_widget.dart';
import '../views/worker/membership/subscription_components/payment_successful_widget.dart';
import '../views/worker/my_jobs_and_components/my_jobs.dart';
import '../views/worker/orders/orders_list.dart';
import '../views/worker/products/products.dart';
import '../views/worker/services/services_list.dart';
import '../views/worker/worker_profile.dart';

final goRouter = GoRouter(routes: routes, initialLocation: '/');

final routes = [
  GoRoute(
      path: '/',
      builder: (context, state) =>
          const ServicesList()), //AuthenticationWrapper())
  GoRoute(path: '/landing', builder: (context, state) => LandingPage()),
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
  GoRoute(
      path: '/pdfViewScreen',
      builder: (context, state) => const ResumeScreen()),
  GoRoute(
      path: '/workerProfile',
      builder: (context, state) => const WorkerProfile()),
  GoRoute(
      path: '/companyChat', builder: (context, state) => const CompanyChat()),
  GoRoute(
      path: '/payment', builder: (context, state) => const MembershipWidget()),
  GoRoute(
      path: '/paymentFailed',
      builder: (context, state) {
        verifyCurrentPath();
        return PaymentFailedWidget();
      }),
  GoRoute(
      path: '/paymentFailed/:sessionId',
      builder: (context, state) {
        verifyCurrentPath();
        return PaymentFailedWidget();
      }),
  GoRoute(
      path: '/paymentSuccess',
      builder: (context, state) {
        verifyCurrentPath();
        return PaymentSuccessfulWidget();
      }),
  GoRoute(
      path: '/paymentSuccess/:sessionId',
      builder: (context, state) {
        verifyCurrentPath();
        return PaymentSuccessfulWidget();
      }),
  GoRoute(
      path: '/companyProfile',
      builder: (context, state) => const CompanyProfile()),
  GoRoute(path: '/login', builder: (context, state) => const Login()),
  GoRoute(
      path: '/register', builder: (context, state) => RegistrationProcess()),
  GoRoute(
      path: '/forgot-password',
      builder: (context, state) => ResetPasswordPage()),
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
      path: '/managePayment',
      builder: (context, state) => const ManagePaymentPage()),
  GoRoute(path: '/services', builder: (context, state) => const Products()),
  GoRoute(path: '/offers', builder: (context, state) => const ServicesList()),
  GoRoute(path: '/orders', builder: (context, state) => const OrdersList()),
  GoRoute(
      path: '/createCompanyProfile',
      builder: (context, state) => const CreateCompanyProfile()),
  GoRoute(
      path: '/company-chat', builder: (context, state) => const CompanyChat()),
  GoRoute(
      path: '/chat-message',
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
