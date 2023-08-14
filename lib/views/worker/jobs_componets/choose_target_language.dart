import 'dart:convert';

import 'package:bulkers/providers/job_posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    "zh": "Chinese (Simplified)",
    "es": "Spanish",
    "hi": "Hindi",
    "ar": "Arabic",
    "pt": "Portuguese",
    "bn": "Bengali",
    "ru": "Russian",
    "ja": "Japanese",
    "fr": "French",
    "de": "German",
    "ko": "Korean",
    "it": "Italian",
    "jv": "Javanese",
    "tr": "Turkish",
    "ig": "Igbo"
  }
  ''';

  @override
  Widget build(BuildContext context) {
    var languageMap = jsonDecode(jsonString);
    JobPostsProvider jp = Provider.of<JobPostsProvider>(context);

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
            print(newValue);
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
