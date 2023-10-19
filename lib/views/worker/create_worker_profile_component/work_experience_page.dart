import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blukers/views/common_views/components/index.dart';

import '../../../providers/worker_provider.dart';
import '../../../services/responsive.dart';
import '../../../utils/styles/theme_colors.dart';
import 'work_experience_form.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:blukers/views/common_views/components/timelines/timeline_navigation_button.dart';

class WorkExperiencePage extends StatefulWidget {
  WorkExperiencePage({super.key});

  @override
  State<WorkExperiencePage> createState() => _WorkExperiencePageState();
}

class _WorkExperiencePageState extends State<WorkExperiencePage> {
  List<WorkExperienceForm> workExperienceForms = [];
  ScrollController scrollCtrl = ScrollController();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      //added this listner to dismiss keyboard when scroll
      scrollCtrl.addListener(() {
        print('scrolling');
      });
      scrollCtrl.position.isScrollingNotifier.addListener(() {
        if (!scrollCtrl.position.isScrollingNotifier.value) {
          print('scroll is stopped');
          FocusManager.instance.primaryFocus?.unfocus();
        } else {
          print('scroll is started');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    if (workExperienceForms.isEmpty) {
      for (int i = 0; i < wp.workExperience.length; i++) {
        workExperienceForms.add(WorkExperienceForm(index: i));
      }
    }
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: Responsive.isDesktop(context)
          ? MediaQuery.of(context).size.width * 0.3
          : MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        controller: scrollCtrl,
        child: Column(
          children: [
            ...workExperienceForms,
            Tooltip(
              message: AppLocalizations.of(context)!.addMoreWorkExperience,
              child: InkWell(
                onTap: () {
                  wp.addWorkExperience();
                },
                child: Row(
                  children: [
                    Spacer(),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        wp.addWorkExperience();
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      AppLocalizations.of(context)!.addMoreWorkExperience,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TimelineNavigationButton(
                  isSelected: true,
                  onPress: () => wp.workerProfileBackPage(),
                  navDirection: "back",
                ),
                TimelineNavigationButton(
                  isSelected: true,
                  onPress: () => wp.setWorkExperience(),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     wp.workerProfileBackPage();
                //   },
                //   style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.all<Color>(
                //         ThemeColors.secondaryThemeColor),
                //   ),
                //   child: Text(
                //     AppLocalizations.of(context)!.previous,
                //     style: TextStyle(
                //       fontFamily: "Montserrat",
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     wp.setWorkExperience();
                //   },
                //   style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.all<Color>(
                //         ThemeColors.secondaryThemeColor),
                //   ),
                //   child: Text(
                //     AppLocalizations.of(context)!.next,
                //     style: TextStyle(
                //       fontFamily: "Montserrat",
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
