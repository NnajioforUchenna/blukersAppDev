// list_of_provider.dart
import 'package:blukers/providers/message_provider.dart';
import 'package:blukers/providers/worker_chat_provider.dart';
import 'package:provider/provider.dart';

import '../providers/app_settings_provider.dart';
import '../providers/company_chat_provider.dart';
import '../providers/company_provider.dart';
import '../providers/industry_provider.dart';
import '../providers/job_posts_provider.dart';
import '../providers/jobs_lists_provider.dart';
import '../providers/payment_providers/payments_provider.dart';
import '../providers/user_provider_parts/user_provider.dart';
import '../providers/worker_provider.dart';

final appProviders = [
  ChangeNotifierProvider(create: (context) => AppSettingsProvider()),
  ChangeNotifierProvider(create: (context) => MessageProvider()),
  ChangeNotifierProvider(create: (context) => UserProvider()),
  ChangeNotifierProvider(create: (context) => IndustriesProvider()),
  ChangeNotifierProxyProvider<UserProvider, CompanyChatProvider>(
      create: (context) => CompanyChatProvider(),
      update: (_, user, CompanyChatProvider? previous) =>
          previous!..update(user.appUser)),
  ChangeNotifierProxyProvider<UserProvider, WorkerChatProvider>(
      create: (context) => WorkerChatProvider(),
      update: (_, user, WorkerChatProvider? previous) =>
          previous!..update(user.appUser)),
  ChangeNotifierProxyProvider<UserProvider, JobPostsProvider>(
      create: (context) => JobPostsProvider(),
      update: (_, user, JobPostsProvider? previous) =>
          previous!..update(user.appUser)),
  ChangeNotifierProxyProvider<UserProvider, JobsListsProvider>(
      create: (context) => JobsListsProvider(),
      update: (_, user, JobsListsProvider? previous) =>
          previous!..update(user.appUser)),
  ChangeNotifierProxyProvider<UserProvider, PaymentsProvider>(
    create: (context) => PaymentsProvider(),
    update: (_, user, PaymentsProvider? previous) =>
        previous!..update(user.appUser),
  ),
  ChangeNotifierProxyProvider<UserProvider, CompanyProvider>(
    create: (context) => CompanyProvider(),
    update: (_, user, CompanyProvider? previous) =>
        previous!..update(user.appUser),
  ),
  ChangeNotifierProxyProvider<UserProvider, WorkersProvider>(
      create: (context) => WorkersProvider(),
      update: (_, user, WorkersProvider? previous) =>
          previous!..update(user.appUser)),
];
