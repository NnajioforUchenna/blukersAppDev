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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<String>(
        hint: const Text('Choose a language'),
        value: selectedLanguageCode,
        onChanged: (String? newValue) {
          setState(() {
            selectedLanguageCode = newValue;
            up.updateTargetLanguage(selectedLanguageCode);
            jp.translateJobPosts(selectedLanguageCode);
            asp.setLocale(selectedLanguageCode);
          });
        },
        items: languageMap.keys.map<DropdownMenuItem<String>>((key) {
          return DropdownMenuItem<String>(
            value: key,
            child: Text(languageMap[key]),
          );
        }).toList(),
        isExpanded: true,
        underline: const SizedBox(),
        icon: const Icon(Icons.language),
        dropdownColor: Colors.blue[100],
      ),
    );
  }
}
