import 'package:flutter/material.dart';

import '../../display_workers/display_workers.dart';
import 'workers_preferences_card.dart';

class ShowWorkersByPreferences extends StatelessWidget {
  const ShowWorkersByPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        //WorkersPreferencesCard(),
        Expanded(child: DisplayWorkers()),
      ],
    );
  }
}
