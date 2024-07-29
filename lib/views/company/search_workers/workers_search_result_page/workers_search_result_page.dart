import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/worker.dart';
import '../../../../providers/worker_provider.dart';
import '../../../../services/responsive.dart';
import '../../../worker/jobs_home/job_home_components/jobs_desktop_view/jobs_desktop_view_components/select_desktop_language_dialog.dart';
import '../../../worker/search_jobs/job_search_bar_components/job_all_search_bar.dart';
import '../../worker_home/worker_home_components/workers_mobile_view/workers_mobile_view_components/search_and_translate_row.dart';
import 'components/complete_worker_widget.dart';

class WorkerSearchResultPage extends StatelessWidget {
  const WorkerSearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    WorkerProvider wp = Provider.of<WorkerProvider>(context);
    List<Worker> workers = wp.selectedWorkers;
    return SingleChildScrollView(
      child: Column(
        children: [
          if (Responsive.isMobile(context)) ...[
            const SearchAndTranslateRowCompany(),
          ] else ...[
            const JobAllSearchBar(),
            const SizedBox(height: 10),
            const Center(child: SelectDesktopLanguageDialog()),
            const SizedBox(height: 10),
            const Divider(),
          ],
          CompleteWorkerWidget(workers: workers),
        ],
      ),
    );
  }
}
