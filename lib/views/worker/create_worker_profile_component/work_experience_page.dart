import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blukers/views/common_views/components/index.dart';

import '../../../providers/worker_provider.dart';
import '../../../services/responsive.dart';
import '../../../utils/styles/theme_colors.dart';
import 'work_experience_form.dart';

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
              message: "Add more Work Experience",
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
                    const Text(
                      "Add more Work Experience",
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    wp.workerProfileBackPage();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ThemeColors.secondaryThemeColor),
                  ),
                  child: const Text("Previous"),
                ),
                ElevatedButton(
                  onPressed: () {
                    wp.setWorkExperience();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        ThemeColors.secondaryThemeColor),
                  ),
                  child: const Text("Next"),
                ),
              ],
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
