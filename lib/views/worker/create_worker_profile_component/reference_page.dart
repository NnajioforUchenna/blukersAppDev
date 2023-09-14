import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blukers/views/common_views/components/index.dart';

import '../../../providers/worker_provider.dart';
import '../../../utils/styles/theme_colors.dart';
import 'reference_form.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReferencePage extends StatefulWidget {
  ReferencePage({Key? key}) : super(key: key);

  @override
  State<ReferencePage> createState() => _ReferencePageState();
}

class _ReferencePageState extends State<ReferencePage> {
  List<ReferenceForm> referenceForms = [];
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
    if (referenceForms.isEmpty) {
      for (int i = 0; i < wp.references.length; i++) {
        referenceForms.add(ReferenceForm(index: i));
      }
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        controller: scrollCtrl,
        child: Column(
          children: [
            ...referenceForms,
            Tooltip(
              message: AppLocalizations.of(context)!.addMorePersonalReferences,
              child: InkWell(
                onTap: () {
                  wp.addReference();
                },
                child: Row(
                  children: [
                    Spacer(),
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
                  ElevatedButton(
                    onPressed: () {
                      wp.workerProfileBackPage();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ThemeColors.secondaryThemeColor),
                    ),
                    child: Text(AppLocalizations.of(context)!.previous),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      wp.setReference();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ThemeColors.secondaryThemeColor),
                    ),
                    child: Text(AppLocalizations.of(context)!.next),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }
}
