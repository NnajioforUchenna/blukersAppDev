import 'package:bulkers/firebase_options.dart';
import 'package:bulkers/providers/chat_provider.dart';
import 'package:bulkers/providers/company_provider.dart';
import 'package:bulkers/providers/industry_provider.dart';
import 'package:bulkers/providers/job_posts_provider.dart';
import 'package:bulkers/providers/user_provider.dart';
import 'package:bulkers/providers/worker_provider.dart';
import 'package:bulkers/services/generate_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'views/auth/common_widget/supported_Locales.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      child: MaterialApp(
        title: "Blukers",
        debugShowCheckedModeBanner: false,
        supportedLocales: supportedLocales,
        localizationsDelegates: [
          CountryLocalizations.delegate,
          // GlobalMaterialLocalizations.delegate,
          // GlobalWidgetsLocalizations.delegate,
        ],
        builder: EasyLoading.init(),
        theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          // useMaterial3: true,
          primarySwatch: Colors.blue,
          fontFamily: 'Montserrat-Regular.ttf',
        ),
        initialRoute: '/',
        onGenerateRoute: generateRoute,
      ),
    );
  }
}
