import 'package:bulkers/firebase_options.dart';
import 'package:bulkers/l10n/l10n.dart';
import 'package:bulkers/providers/chat_provider.dart';
import 'package:bulkers/providers/company_provider.dart';
import 'package:bulkers/providers/industry_provider.dart';
import 'package:bulkers/providers/job_posts_provider.dart';
import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/providers/worker_provider.dart';
import 'package:bulkers/services/generate_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IndustriesProvider()),
        ChangeNotifierProvider(create: (context) => JobPostsProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => ChatProvider()),
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
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            title: "Blukers",
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
            onGenerateRoute: generateRoute,
            initialRoute: "/",
            navigatorKey: navigatorKey,
          );
        },
      ),
    );
  }
}
