import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../models/worker.dart';
import '../../../providers/company_provider.dart';
import '../../../providers/worker_provider.dart';
import '../../common_vieiws/icon_text_404.dart';
import '../../common_vieiws/policy_terms/policy_terms_components/loading_animation.dart';
import '../search_workers/workers_search_result_page/components/complete_worker_widget.dart';

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
