import 'package:blukers/views/common_vieiws/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/worker.dart';
import '../../../../providers/worker_provider.dart';
import '../../../../services/responsive.dart';
import '../../../worker/jobs_home/job_home_components/jobs_desktop_view/jobs_desktop_view_components/select_desktop_language_dialog.dart';
import '../../workers_home/worker_home_mobile/search_and_translate_row.dart';
import '../worker_search_bar_components/worker_all_search_bar.dart';
import 'components/complete_worker_widget.dart';

class WorkerSearchResultPage extends StatelessWidget {
  const WorkerSearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    WorkersProvider wp = Provider.of<WorkersProvider>(context);
    List<Worker> workers = wp.selectedWorkers;
    final screenWidth = MediaQuery.of(context).size.width;

    if (workers.isEmpty) {
      return const LoadingPage();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          if (Responsive.isMobile(context)) ...[
            const SearchAndTranslateRowCompany(),
          ] else ...[
            const WorkerAllSearchBar(),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                  width: screenWidth * 0.6,
                  child: const SelectDesktopLanguageDialog()),
            ),
            const SizedBox(height: 10),
            const Divider(),
          ],
          CompleteWorkerWidget(workers: workers),
        ],
      ),
    );
  }
}
