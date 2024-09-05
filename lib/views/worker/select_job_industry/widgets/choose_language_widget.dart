import 'dart:convert';

import 'package:blukers/providers/job_posts_provider.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:blukers/views/worker/jobs_home/job_home_components/jobs_mobile_view/jobs_mobile_view_compnents/select_language_dialog.dart'; //fix
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../providers/app_settings_provider.dart';
import '../../../../providers/user_provider_parts/user_provider.dart';

class ChooseLanguageWidget extends StatefulWidget {
  const ChooseLanguageWidget({super.key});

  @override
  State<ChooseLanguageWidget> createState() => _ChooseLanguageWidgetState();
}

class _ChooseLanguageWidgetState extends State<ChooseLanguageWidget> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.085;

    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => const SelectLanguageDialog());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color.fromRGBO(207, 207, 207, 1)),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(left: 5),
        width: size,
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/world.svg",
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: ThemeColors.black1ThemeColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class LanguageManager {
  static Locale? _currentLocale;
  static Function(Locale)? _onLanguageChange;

  static void setLanguage(Locale newLocale) {
    _currentLocale = newLocale;
    if (_onLanguageChange != null) {
      _onLanguageChange!(newLocale);
    }
  }

  static Locale? getCurrentLocale() {
    return _currentLocale;
  }

  static void setLanguageChangeListener(Function(Locale) listener) {
    _onLanguageChange = listener;
  }
}

class ChooseLanguageWidgetDesktop extends StatefulWidget {
  const ChooseLanguageWidgetDesktop({super.key});

  @override
  State<ChooseLanguageWidgetDesktop> createState() =>
      _ChooseLanguageWidgetDesktopState();
}

class _ChooseLanguageWidgetDesktopState
    extends State<ChooseLanguageWidgetDesktop> {
  String? selectedLanguageCode;

  String jsonString = '''
{
  "en": "English",
  "es": "Spanish",
  "ar": "Arabic",
  "zh": "Chinese (Simplified)",
  "fr": "French",
  "de": "German",
  "it": "Italian",
  "ko": "Korean",
  "pt": "Portuguese",
  "ru": "Russian",
  "tr": "Turkish"
}
''';

  @override
  Widget build(BuildContext context) {
    var languageMap = jsonDecode(jsonString);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);
    UserProvider up = Provider.of<UserProvider>(context);
    AppSettingsProvider asp = Provider.of<AppSettingsProvider>(context);

    return Container(
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color.fromRGBO(207, 207, 207, 1)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: PopupMenuButton<String>(
        color: Colors.blue[100],
        position: PopupMenuPosition.under,
        onSelected: (String newValue) {
          setState(() {
            selectedLanguageCode = newValue;
            up.updateTargetLanguage(selectedLanguageCode);
            jp.translateJobPosts(selectedLanguageCode);
            asp.setLocale(selectedLanguageCode);
          });
        },
        itemBuilder: (BuildContext context) {
          return languageMap.keys.map<PopupMenuEntry<String>>((String key) {
            bool isSelected = selectedLanguageCode == key;
            return PopupMenuItem<String>(
              value: key,
              child: Text(languageMap[key],
                  style: TextStyle(
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                      color:
                          isSelected ? ThemeColors.secondaryThemeColor : null)),
            );
          }).toList();
        },
        child: const Row(
          children: [
            Icon(
              Icons.language,
              color: ThemeColors.black1ThemeColor,
              size: 25,
            ),
            SizedBox(
              width: 5,
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: ThemeColors.black1ThemeColor,
              size: 25,
            ),
          ],
        ),
      ),
    );
  }
}
