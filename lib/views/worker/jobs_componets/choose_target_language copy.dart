import 'dart:convert';

import 'package:blukers/providers/job_posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_provider.dart';

class ChooseTargetLanguage extends StatefulWidget {
  const ChooseTargetLanguage({super.key});

  @override
  _ChooseTargetLanguageState createState() => _ChooseTargetLanguageState();
}

class _ChooseTargetLanguageState extends State<ChooseTargetLanguage> {
  String? selectedLanguageCode;

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
            up.updateTargetLanguage(newValue);
            jp.translateJobPosts(newValue);
          });
        },
        items: languageMap.keys.map<DropdownMenuItem<String>>((key) {
          return DropdownMenuItem<String>(
            value: key,
            child: Text(languageMap[key]),
          );
        }).toList(),
        isExpanded: true,
        underline: SizedBox(),
        icon: const Icon(Icons.language),
        dropdownColor: Colors.blue[100],
      ),
    );
  }
}
