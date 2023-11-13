import 'package:flutter/material.dart';

import 'select_language_dialog.dart';

class JobsMobileChooseTargetLanguage extends StatefulWidget {
  const JobsMobileChooseTargetLanguage({super.key});

  @override
  State<JobsMobileChooseTargetLanguage> createState() =>
      _JobsMobileChooseTargetLanguageState();
}

class _JobsMobileChooseTargetLanguageState
    extends State<JobsMobileChooseTargetLanguage> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.085;
    double iconSize = size * 0.8;
    return InkWell(
      onTap: () {
        showDialog(
            context: context, builder: (context) => SelectLanguageDialog());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(left: 5),
        width: size,
        height: size,
        child: Center(
            child: Icon(Icons.language, size: iconSize, color: Colors.grey)),
      ),
    );
  }
}
