import 'dart:convert';

import 'package:blukers/providers/job_posts_provider.dart';
import 'package:blukers/utils/styles/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

class ChooseTargetLanguage extends StatefulWidget {
  const ChooseTargetLanguage({super.key});

  @override
  _ChooseTargetLanguageState createState() => _ChooseTargetLanguageState();
}

class _ChooseTargetLanguageState extends State<ChooseTargetLanguage> {
  String? selectedLanguageCode;

//   String jsonString = '''
// {
//   "en": "English",
//   "es": "Spanish"
// }
// ''';

  String jsonString = '''
{
  "en": "English",
  "es": "Spanish",
  "ar": "Arabic",
  "bn": "Bengali",
  "zh": "Chinese (Simplified)",
  "fr": "French",
  "de": "German",
  "hi": "Hindi",
  "ig": "Igbo",
  "it": "Italian",
  "ja": "Japanese",
  "jv": "Javanese",
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

    Color primaryColor = ThemeColors.grey1ThemeColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        hint: Text(
          AppLocalizations.of(context)?.language ?? "",
          style: TextStyle(
            color: primaryColor,
            fontFamily: 'Montserrat',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        value: selectedLanguageCode,
        onChanged: (String? newValue) {
          //
          // print('newValue');
          // print(newValue);
          if (newValue.toString() == "es") {
            LanguageManager.setLanguage(const Locale("es"));
          } else {
            LanguageManager.setLanguage(const Locale("en"));
          }
          // print("LanguageManager.getCurrentLocale()");
          // print(LanguageManager.getCurrentLocale());
          //
          setState(() {
            selectedLanguageCode = newValue;
            up.updateTargetLanguage(newValue);
            jp.translateJobPosts(newValue);
          });
        },
        items: languageMap.keys.map<DropdownMenuItem<String>>((key) {
          return DropdownMenuItem<String>(
            value: key,
            child: Text(
              languageMap[key],
              style: TextStyle(
                color: primaryColor,
                fontFamily: 'Montserrat',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
        isExpanded: false,
        underline: const SizedBox(),
        icon: Icon(
          Icons.language,
          color: primaryColor,
        ),
        // dropdownColor: Colors.blue[100],
        dropdownColor: Colors.white,
      ),
    );
  }
}
