import 'package:blukers/firebase_options.dart';
import 'package:blukers/l10n/l10n.dart';
import 'package:blukers/providers/app_versions_provider.dart';
import 'package:blukers/providers/chat_provider.dart';
import 'package:blukers/providers/company_provider.dart';
import 'package:blukers/providers/industry_provider.dart';
import 'package:blukers/providers/job_posts_provider.dart';
import 'package:blukers/providers/payment_providers/payments_provider.dart';
import 'package:blukers/providers/user_provider_parts/user_provider.dart';
import 'package:blukers/providers/worker_provider.dart';
import 'package:blukers/providers/product_providers/product_provider.dart';
import 'package:blukers/providers/product_providers/product_category_provider.dart';
import 'package:blukers/providers/product_providers/product_subcategory_provider.dart';
import 'package:blukers/providers/product_providers/product_status_provider.dart';
import 'package:blukers/services/generate_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setPathUrlStrategy();
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final appcastURL =
    //     'https://raw.githubusercontent.com/larryaasen/upgrader/master/test/testappcast.xml';
    // final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);

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
        upgrader: Upgrader(
          // durationUntilAlertAgain: Duration(seconds: 2),
          // debugDisplayAlways: true,
          // debugLogging: true,
          showIgnore: false,
          showLater: false,
        ),
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
                // useMaterial3: true,
                // colorScheme:
                //     ColorScheme.fromSeed(seedColor: Color.fromRGBO(30, 117, 187, 1)),
                // // Setup your ThemeData colorScheme manually:
                // colorScheme: const ColorScheme(
                //   brightness: Brightness.light,
                //   primary: Color.fromRGBO(30, 117, 187, 1),
                //   onPrimary: Colors.white,
                //   secondary: Colors.white,
                //   onSecondary: Color.fromARGB(255, 83, 83, 83),
                //   error: Colors.red,
                //   onError: Colors.white,
                //   background: Colors.white,
                //   onBackground: Colors.black,
                //   surface: Colors.white,
                //   onSurface: Color.fromRGBO(30, 117, 187, 1),
                // ),
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
