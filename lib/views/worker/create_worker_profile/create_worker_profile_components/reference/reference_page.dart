import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../../../providers/worker_provider.dart';
import '../timeline_navigation_button.dart';
import 'reference_form.dart';

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