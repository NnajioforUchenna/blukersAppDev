import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_strategy/url_strategy.dart';

import 'firebase_options.dart';
import 'l10n/l10n.dart';
import 'providers/app_versions_provider.dart';
import 'providers/chat_provider.dart';
import 'providers/company_provider.dart';
import 'providers/industry_provider.dart';
import 'providers/job_posts_provider.dart';
import 'providers/payment_providers/payments_provider.dart';
import 'providers/product_providers/product_category_provider.dart';
import 'providers/product_providers/product_provider.dart';
import 'providers/product_providers/product_status_provider.dart';
import 'providers/product_providers/product_subcategory_provider.dart';
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
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<ProductCategoryProvider>(
          create: (context) => ProductCategoryProvider(),
        ),
        ChangeNotifierProvider<ProductSubcategoryProvider>(
          create: (context) => ProductSubcategoryProvider(),
        ),
        ChangeNotifierProvider<ProductStatusProvider>(
          create: (context) => ProductStatusProvider(),
        ),
        ChangeNotifierProvider(create: (context) => IndustriesProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
        ChangeNotifierProvider(create: (context) => AppVersionsProvider()),
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
        ChangeNotifierProxyProvider<UserProvider, WorkerProvider>(
            create: (context) => WorkerProvider(),
            update: (_, user, WorkerProvider? previous) =>
                previous!..update(user.appUser)),
      ],
      child: UpgradeAlert(
        child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp.router(
              title: "Blukers",
              routerConfig: goRouter,
              debugShowCheckedModeBanner: false,
              // LOCALIZATION
              // - Manually set a locale:
              // locale: const Locale('en'),
              // - supportedLocales, if they match the phone's locale,
              // flutter automatically use the langage for the given delegates.
              // If they don't match the phone's locale, default locale will be 'en'.
              supportedLocales: L10n.all,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              //
              builder: EasyLoading.init(),
              theme: ThemeData(
                primarySwatch: Colors.blue,
                fontFamily: 'Montserrat',
              ),
              // home: AuthenticationWrapper(),
              // onGenerateRoute: generateRoute,
              // initialRoute: "/",
              // navigatorKey: navigatorKey,
            );
          },
        ),
      ),
    );
  }
}
