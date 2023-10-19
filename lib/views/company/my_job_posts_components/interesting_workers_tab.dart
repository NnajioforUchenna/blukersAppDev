import 'package:blukers/models/worker.dart';
import 'package:blukers/providers/company_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../providers/worker_provider.dart';
import '../workers_components/complete_worker_widget.dart';

import 'package:blukers/views/common_views/components/icon_text_404.dart';
import 'package:unicons/unicons.dart';

import 'package:blukers/views/common_views/components/loading_animation.dart';

class InterestingWorkersTab extends StatelessWidget {
  const InterestingWorkersTab({super.key});

  @override
  Widget build(BuildContext context) {
    CompanyProvider cp = Provider.of<CompanyProvider>(context);
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    return StreamBuilder<List<Worker>>(
      stream: cp.getInterestingWorkersStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingAnimation();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // return const NoInterestingWorkers();
          return IconText404(
              text: AppLocalizations.of(context)!.youHaveNotSavedAnyWorker,
              icon: UniconsLine.constructor);
        } else {
          List<Worker> workers = snapshot.data!;
          return CompleteWorkerWidget(workers: workers);
        }
      },
    );
  }
}
