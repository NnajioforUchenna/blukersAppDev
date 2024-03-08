import '../../../../../../providers/worker_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../old_common_views/components/timelines/timeline_navigation_button.dart';
import 'reference_form.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReferencePage extends StatefulWidget {
  const ReferencePage({super.key});

  @override
  State<ReferencePage> createState() => _ReferencePageState();
}

class _ReferencePageState extends State<ReferencePage> {
  List<ReferenceFormWidget> referenceForms = [];
  ScrollController scrollCtrl = ScrollController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    if (referenceForms.isEmpty) {
      for (int i = 0; i < wp.references.length; i++) {
        referenceForms.add(ReferenceFormWidget(index: i));
      }
    }
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        controller: scrollCtrl,
        child: Column(
          children: [
            const SizedBox(height: 20),
            ...referenceForms,
            Tooltip(
              message: AppLocalizations.of(context)!.addMorePersonalReferences,
              child: InkWell(
                onTap: () {
                  wp.addReference();
                },
                child: Row(
                  children: [
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        wp.addReference();
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      AppLocalizations.of(context)!.addMorePersonalReferences,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TimelineNavigationButton(
                    isSelected: true,
                    onPress: () => wp.workerProfileBackPage(),
                    navDirection: "back",
                  ),
                  TimelineNavigationButton(
                    isSelected: true,
                    onPress: () => wp.setReference(),
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
                  //     wp.setReference();
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
            ),
            const SizedBox(height: 150)
          ],
        ),
      ),
    );
  }
}
