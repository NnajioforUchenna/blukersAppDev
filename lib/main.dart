import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:url_strategy/url_strategy.dart';

import 'firebase_options.dart';
import 'l10n/l10n.dart';
import 'providers/app_settings_provider.dart';
import 'providers/chat_provider.dart';
import 'providers/company_provider.dart';
import 'providers/industry_provider.dart';
import 'providers/job_posts_provider.dart';
import 'providers/payment_providers/payments_provider.dart';
import 'providers/user_provider_parts/user_provider.dart';
import 'providers/worker_provider.dart';
import 'services/generate_route.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Error: $e');
  }

  setPathUrlStrategy();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppSettingsProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => IndustriesProvider()),
        ChangeNotifierProxyProvider<UserProvider, ChatProvider>(
            create: (context) => ChatProvider(),
            update: (_, user, ChatProvider? previous) =>
                previous!..update(user.appUser)),
        ChangeNotifierProxyProvider<UserProvider, JobPostsProvider>(
            create: (context) => JobPostsProvider(),
            update: (_, user, JobPostsProvider? previous) =>
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
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return ShowCaseWidget(
            builder: (context) {
              AppSettingsProvider ap =
                  Provider.of<AppSettingsProvider>(context);
              return MaterialApp.router(
                title: "Blukers",
                routerConfig: goRouter,
                debugShowCheckedModeBanner: false,
                locale: ap.myLocale,
                supportedLocales: L10n.all,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                builder: (context, widget) {
                  return EasyLoading.init()(context, widget);
                },
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  fontFamily: 'Montserrat',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
