import 'dart:convert';

import 'package:blukers/providers/app_settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/job_posts_provider.dart';
import '../../../../../../providers/user_provider_parts/user_provider.dart';

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

class SelectLanguageDialog extends StatefulWidget {
  const SelectLanguageDialog({super.key});

  @override
  State<SelectLanguageDialog> createState() => _SelectLanguageDialogState();
}

class _SelectLanguageDialogState extends State<SelectLanguageDialog> {
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

    return SimpleDialog(
      title: const Text('Select Language'),
      children: languageMap.keys.map<SimpleDialogOption>((key) {
        return SimpleDialogOption(
          onPressed: () {
            // Update the state and close dialog
            setState(() {
              selectedLanguageCode = key;
              up.updateTargetLanguage(selectedLanguageCode);
              jp.translateJobPosts(selectedLanguageCode);
              asp.setLocale(selectedLanguageCode);
            });
            Navigator.of(context).pop();
          },
          child: Text(languageMap[key]),
        );
      }).toList(),
    );
  }
}
