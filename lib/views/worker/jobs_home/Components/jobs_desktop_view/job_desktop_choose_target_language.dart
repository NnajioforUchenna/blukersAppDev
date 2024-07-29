import 'package:flutter/material.dart';

import '../../job_home_components/jobs_mobile_view/jobs_mobile_view_compnents/select_language_dialog.dart';

class JobsDeskTopChooseTargetLanguage extends StatefulWidget {
  const JobsDeskTopChooseTargetLanguage({super.key});

  @override
  State<JobsDeskTopChooseTargetLanguage> createState() =>
      _JobsDeskTopChooseTargetLanguageState();
}

class _JobsDeskTopChooseTargetLanguageState
    extends State<JobsDeskTopChooseTargetLanguage> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 0.085;
    double iconSize = size * 0.8;
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => const SelectLanguageDialog());
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
